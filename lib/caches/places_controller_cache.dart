import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:simple_cache/simple_cache.dart';

class PlacesControllerCache extends SimpleCache<Place, int> {
  PlacesControllerCache({required super.config, required super.cloudOps});

  static PlacesControllerCache initialize() {
    return PlacesControllerCache(
      config: SimpleCacheConfig<Place, int>(
        dbName: 'cache',
        tableName: 'places',
        fromJson: (json) => Place.fromJson(json),
        toJson: (a) => a.toJson(),
        hitCondition: (a, i) => a.id == i,
        getIdentifier: (a) => a.id!,
        sort: (list){
          var newList = [...list];
          newList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
          return newList;
        }
      ),
      cloudOps: CloudOperations<Place, int>(
        getAll: () => PlaceRepo().fetchMany(),
        getOne: (i) => PlaceRepo().fetchOne(i),
        create: (a) => PlaceRepo().save(a),
        update: (a) => PlaceRepo().save(a),
        delete: (a) => PlaceRepo().delete(a.id!)
      )
    );
  }

  Future<List<Place>> search(String q) async {
    if(q.isEmpty) return await getAll();

    if(await hasInternet()){
      final res = await PlaceRepo().search(q);
      print('searched places from internet');
      replaceAllInCache(res);
      return res;
    } else {
      var res = getAllFromCache();
      print('searched places from caches');
      return res.where((e) => (e.name ?? '').contains(q)).toList();
    }
  }
}