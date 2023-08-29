
import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/models/_all.dart';

const _tableName = 'friend_requests';

class FriendRequestRepo{
  Future<FriendRequest> create(FriendRequest resource) async {
    final resJson = await supabase.from(_tableName)
        .insert(resource.toJson())
        .select().maybeSingle() as Map<String, dynamic>?;
    return FriendRequest.fromJson(resJson!);
  }

  Future<FriendRequest> update(FriendRequest resource) async {
    final resJson = await supabase.from(_tableName)
        .update(resource.toJson())
        .eq('id', resource.id)
        .select().maybeSingle() as Map<String, dynamic>?;
    return FriendRequest.fromJson(resJson!);
  }

  Future<void> delete(int id) async {
    final data = await supabase
        .from(_tableName)
        .delete()
        .match({ 'id': id });
    print('----------Data: $data');
  }

  Future<FriendRequest?> fetchOne(int id) async {
    var filterBuilder = supabase.from(_tableName).select('*').eq('id', id);

    final res = await filterBuilder.maybeSingle() as Map<String, dynamic>?;

    print("FETCHED ONE(FR) is $res");
    if(res == null) return null;

    return FriendRequest.fromJson(res);
  }

  Future<FriendRequest?> fetchOneByUid(String uid) async {
    var filterBuilder = supabase.from(_tableName).select('*')
        .or('receiver_uid.eq.$uid,sender_uid.eq.$uid');

    final res = await filterBuilder.maybeSingle() as Map<String, dynamic>?;

    print("FETCHED ONE(FR) is $res");
    if(res == null) return null;

    return FriendRequest.fromJson(res);
  }

  // TODO: revise
  Future<FriendRequest?> fetchOneUids(String uid1, String uid2) async {
    var filterBuilder = supabase.from(_tableName).select('*')
        .or('receiver_uid.eq.$uid2,sender_uid.eq.$uid1')
        .or('receiver_uid.eq.$uid1,sender_uid.eq.$uid2');

    final res = await filterBuilder.maybeSingle() as Map<String, dynamic>?;

    print("FETCHED ONE(FR) is $res");
    if(res == null) return null;

    return FriendRequest.fromJson(res);
  }

  Future<List<FriendRequest>> fetchMany() async {
    var filterBuilder = supabase.from(_tableName).select('*');

    final response = await filterBuilder
        .eq('receiver_uid', supabase.auth.currentUser!.id)
        .order('created_at', ascending: false)
        as List;
    print("FETCHED MANY(FR) is $response");

    return convertMapListToObjs(response);
  }

  List<FriendRequest> convertMapListToObjs(List response) {
    List<FriendRequest> list = [];
    for (var element in response) {
      list.add(FriendRequest.fromJson(element));
    }
    return list;
  }
}