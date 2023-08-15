library simple_cache;

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:localstorage/localstorage.dart';

class CannotCreateWithoutInternetException implements Exception {
  @override
  String toString() {
    return 'Cannot create with no internet';
  }
}

class CannotUpdateWithoutInternetException implements Exception {
  @override
  String toString() {
    return 'Cannot update with no internet';
  }
}

class CannotDeleteWithoutInternetException implements Exception {
  @override
  String toString() {
    return 'Cannot delete with no internet';
  }
}

class CloudOperationMissingException implements Exception {
  final String operation;
  CloudOperationMissingException(this.operation);

  @override
  String toString() {
    // TODO: implement toString
    return 'Cloud operation "$operation" is missing!';
  }
}


class SimpleCacheConfig<T, I>{
  final String dbName;
  final String tableName;
  final bool Function(T a, I b) hitCondition;
  final T Function(Map<String, dynamic> json) fromJson;
  final Map<String, dynamic> Function(T a) toJson;
  final I Function(T a) getIdentifier;
  final List<T> Function(List<T> list)? sort;

  SimpleCacheConfig({
    required this.dbName,
    required this.tableName,
    required this.fromJson,
    required this.toJson,
    required this.hitCondition,
    required this.getIdentifier,
    this.sort
  });
}


class CloudOperations<T, I> {
  final Future<List<T>> Function()? getAll;
  final Future<T?> Function(I identifier)? getOne;
  final Future<T?> Function(T a)? create;
  final Future<T?> Function(T a)? update;
  final Future<void> Function(T a)? delete;

  CloudOperations({
    this.getAll,
    this.getOne,
    this.create,
    this.update,
    this.delete,
  });
}

class SimpleCache<T, I>{
  late LocalStorage storage;
  final SimpleCacheConfig<T, I> config;
  final CloudOperations<T, I> cloudOps;

  SimpleCache({
    required this.config,
    required this.cloudOps
  }) {
    storage = LocalStorage('${config.dbName}_data.json');
  }

  List<T> getAllFromCache(){
    final values = storage.getItem(config.tableName);
    if(values == null) return [];

    return values.toList();
  }

  List<T> replaceAllInCache(List<T> list){
    storage.setItem(config.tableName, list);
    return list;
  }

  Future<List<T>> getAll() async {
    if(cloudOps.getAll != null){
      if(await hasInternet()){
        final res = await cloudOps.getAll!();
        print('got all from internet');
        replaceAllInCache(res);
        return res;
      }
    }
    print('got all from cache');
    return getAllFromCache();
  }

  bool get hasLocalData{
    return getAllFromCache().isNotEmpty;
  }

  Future<T?> getOne(I identifier) async {
    if(cloudOps.getOne != null){
      if(await hasInternet()){
        final res = await cloudOps.getOne!(identifier);
        print('got one from internet');
        if(res == null) return null;
        createOrUpdateInCache(res);
        return res;
      }
    }

    print('got one from cache');
    return getAllFromCache().firstWhere((e) => config.hitCondition(e, identifier));
  }

  T createOrUpdateInCache(T a){
    List<T> oldResources = getAllFromCache();
    int? foundIndex = foundAt(a, oldResources);
    if(foundIndex == null) {
      oldResources.add(a);
      if(config.sort != null){
        oldResources = config.sort!(oldResources);
      }
    } else {
      oldResources[foundIndex] = a;
    }
    storage.setItem(config.tableName, oldResources);
    return a;
  }

  int? foundAt(T a, [List<T>? oldResources]){
    oldResources ??= getAllFromCache();

    int? foundIndex;
    for(var i = 0; i < oldResources.length; i++){
      if(config.hitCondition(oldResources[i], config.getIdentifier(a))){
        foundIndex = i;
        break;
      }
    }
    return foundIndex;
  }

  T deleteFromCache(T a){
    List<T> oldResources = getAllFromCache();
    int? foundIndex = foundAt(a, oldResources);
    if(foundIndex != null) {
      oldResources.removeAt(foundIndex);
      return a;
    }

    throw Exception('Cannot delete an object that doesn\'t exist');
  }

  Future<T?> create(T a) async {
    if(cloudOps.create != null){
      if(await hasInternet()){
        final res = await cloudOps.create!(a);
        if(res == null) return null;
        createOrUpdateInCache(res);
        return res;
      } else {
        throw CannotCreateWithoutInternetException();
      }
    } else {
      throw CloudOperationMissingException('create');
    }
  }


  Future<T?> update(T a) async {
    if(cloudOps.update != null){
      if(await hasInternet()){
        final res = await cloudOps.update!(a);
        if(res == null) return null;
        createOrUpdateInCache(res);
        return res;
      } else {
        throw CannotUpdateWithoutInternetException();
      }
    } else {
      throw CloudOperationMissingException('update');
    }
  }


  Future<void> delete(T a) async {
    // handle cases when it is not present in cloud. Need to delete locally as well
    if(cloudOps.delete != null){
      if(await hasInternet()){
        await cloudOps.delete!(a);
        deleteFromCache(a);
        return;
      } else {
        throw CannotDeleteWithoutInternetException();
      }
    } else {
      throw CloudOperationMissingException('delete');
    }
  }

  Future<bool> hasInternet() async {
    return await InternetConnectionChecker().hasConnection;
  }
}