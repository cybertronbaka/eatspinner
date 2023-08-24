import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:simple_cache/simple_cache.dart';

class ProfilesCache extends SimpleCache<Profile, String> {
  ProfilesCache({required super.config, required super.cloudOps});

  static ProfilesCache initialize() {
    return ProfilesCache(
        config: SimpleCacheConfig<Profile, String>(
          dbName: 'cache',
          tableName: 'profiles',
          fromJson: (json) => Profile.fromJson(json),
          toJson: (a) => a.toJson(),
          hitCondition: (a, i) => a.userId == i,
          getIdentifier: (a) => a.userId!,
        ),
        cloudOps: CloudOperations<Profile, String>(
          getOne: (i) => ProfileRepo().fetchByUid(i),
          create: (a) => ProfileRepo().create(a),
          update: (a) => ProfileRepo().update(a),
        )
    );
  }
}