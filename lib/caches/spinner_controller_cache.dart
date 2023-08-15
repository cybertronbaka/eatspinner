import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:latlong2/latlong.dart';
import 'package:simple_cache/simple_cache.dart';

class SpinnerControllerCache extends SimpleCache<Place, int> {
  SpinnerControllerCache({required super.config, required super.cloudOps});

  static SpinnerControllerCache initialize() {
    return SpinnerControllerCache(
        config: SimpleCacheConfig<Place, int>(
            dbName: 'cache',
            tableName: 'spinner',
            fromJson: (json) => Place.fromJson(json),
            toJson: (a) => a.toJson(),
            hitCondition: (a, i) => a.id == i,
            getIdentifier: (a) => a.id!
        ),
        cloudOps: CloudOperations<Place, int>(
            getAll: () => PlaceRepo().fetchMany(),
        )
    );
  }

  Future<List<Place>> searchNearby(LatLng latLng) async {
    if(await hasInternet()){
      final res = await PlaceRepo().searchNearby(latLng);
      print('searched nearby places from internet');
      replaceAllInCache(res);
      return res;
    }

    print('searched nearby places from cache');
    return getAllFromCache();
  }
}