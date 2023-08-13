import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/models/_all.dart';

const _tableName = 'profiles';

class ProfileRepo {
  Future<Profile> create(Profile profile) async {
    final resJson = await supabase.from(_tableName)
        .insert(profile.toJson())
        .select().maybeSingle() as Map<String, dynamic>?;
    return Profile.fromJson(resJson!);
  }

  Future<Profile> update(Profile profile) async {
    final resJson = await supabase.from(_tableName)
        .update(profile.toJson())
        .eq('id', profile.id)
        .select().maybeSingle() as Map<String, dynamic>?;
    return Profile.fromJson(resJson!);
  }

  Future<Profile?> _fetch(String key, dynamic value) async {
    var filterBuilder = supabase.from(_tableName).select('*').eq(key, value);

    final res = await filterBuilder.maybeSingle() as Map<String, dynamic>?;

    print("FETCHED ONE(Place) is $res");
    if(res == null) return null;

    return Profile.fromJson(res);
  }

  Future<void> delete(int id) async {
    final data = await supabase
        .from(_tableName)
        .delete()
        .match({ 'id': id });
    print('----------Data: $data');
  }

  Future<Profile?> fetchById(id) => _fetch('id', id);

  Future<Profile?> fetchByUid(uid) => _fetch('user_id', uid);
}