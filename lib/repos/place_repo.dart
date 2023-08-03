import 'package:eatspinner/app/globals.dart';
import 'package:eatspinner/models/_all.dart';
import 'package:latlong2/latlong.dart';

const _tableName = 'places';

class PlaceRepo {

  Future<Place?> save(Place resource) async {
    Map<String, dynamic>? resJson = {};
    print("Attempting to save(Place) is ${resource.id}");
    if(resource.id == null){
      resJson = await supabase.from(_tableName)
          .insert(resource.toJson())
          .select().maybeSingle() as Map<String, dynamic>?;
    } else {
      resJson = await supabase.from(_tableName)
          .update(resource.toJson())
          .eq('id', resource.id)
          .select().maybeSingle() as Map<String, dynamic>?;
    }
    print("SAVED(Place) is $resJson");
    if(resJson == null) return null;

    return Place.fromJson(resJson);
  }

  Future<void> delete(int id) async {
    final data = await supabase
        .from(_tableName)
        .delete()
        .match({ 'id': id });
    print('----------Data: $data');
  }

  Future<Place?> fetchOne(int id) async {
    var filterBuilder = supabase.from(_tableName).select('*').eq('id', id);

    final res = await filterBuilder.maybeSingle() as Map<String, dynamic>?;

    print("FETCHED ONE(Place) is $res");
    if(res == null) return null;

    return Place.fromJson(res);
  }
  
  Future<List<Place>> searchNearby(LatLng latLng) async {
    final data = await supabase.rpc(
      'search_places_nearby',
      params: {
        'latitude': latLng.latitude,
        'longitude': latLng.longitude
      }
    ).limit(8);
    print('DATA: $data');

    return convertMapListToObjs(data);
  }

  Future<List<Place>> search(String query) async {
    final data = await supabase
      .from(_tableName)
      .select('*')
      .ilike('name', '%$query%');
    print('-----------SEARCHED WITH $query');
    print('DATA: $data');
    return convertMapListToObjs(data);
  }

  Future<List<Place>> fetchMany() async {
    var filterBuilder = supabase.from(_tableName).select('*');

    final response = await filterBuilder.order('created_at', ascending: true) as List;
    print("FETCHED MANY(Place) is $response");

    return convertMapListToObjs(response);
  }

  List<Place> convertMapListToObjs(List response) {
    List<Place> tasks = [];
    for (var element in response) {
      tasks.add(Place.fromJson(element));
    }
    return tasks;
  }
}