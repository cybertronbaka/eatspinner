import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/caches/_all.dart';
import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/pages/profile/_all.dart';
import 'package:eatspinner/repos/friend_request_repo.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  late String uid;

  Rx<Profile?> profile = Rx(null);
  Rx<bool> isFetching = true.obs;
  Rx<FriendRequest?> friendRequest = Rx(null);
  Rx<ProfileMainActionMode> actionMode = Rx(ProfileMainActionMode.none);

  final cache = ProfilesCache.initialize();

  void init({required String uid}){
    this.uid = uid;
  }

  Future<void> fetchProfile() async {
    isFetching.value = true;
    try{
      profile.value = await cache.getOne(uid);
      isFetching.value = false;
      if(supabase.auth.currentUser!.id == uid) return;

      if(await isFriendRequestSent()){
        assignActionMode();
      }
    } catch(e, stck){
      isFetching.value = false;
      EsToast.showError(e.toString(), stck);
    }
  }

  void assignActionMode(){
    if(friendRequest.value != null){
      if(friendRequest.value!.accepted == null){
        if(friendRequest.value!.receiverUid! == supabase.auth.currentUser!.id){
          actionMode.value = ProfileMainActionMode.accept;
        } else {
          actionMode.value = ProfileMainActionMode.requestAlreadySent;
        }
      } else if(friendRequest.value!.accepted!){
        actionMode.value = ProfileMainActionMode.alreadyFriends;
      } else {
        actionMode.value = ProfileMainActionMode.rejected;
      }
    } else {
      actionMode.value = ProfileMainActionMode.addToContact;
    }
  }

  Future<bool> isFriendRequestSent() async {
    friendRequest.value = await FriendRequestRepo().fetchOneByUid(uid);
    return friendRequest.value != null;
  }

  Future<FriendRequest?> addToContact() async {
    try {
      final res =  await FriendRequestRepo().create(FriendRequest(senderUid: supabase.auth.currentUser!.id, receiverUid: uid));
      friendRequest.value = res;
      assignActionMode();
      return res;
    } catch(e){
      EsToast.showError(e.toString());
      return null;
    }
  }

  Future<FriendRequest?> acceptRequest() async {
    try {
      final res = await FriendRequestRepo().update(
        friendRequest.value!.copyWith(accepted: true)
      );
      friendRequest.value = res;
      assignActionMode();
      return res;
    } catch(e){
      EsToast.showError(e.toString());
      return null;
    }
  }

  Future<void> rejectRequest() async {
    try {
      final res = await FriendRequestRepo().update(
        friendRequest.value!.copyWith(accepted: false)
      );
      friendRequest.value = res;
      assignActionMode();
    } catch(e){
      EsToast.showError(e.toString());
    }
  }

  Future<void> cancelRequest() async {
    try {
      await FriendRequestRepo().delete(friendRequest.value!.id!);
      friendRequest.value = null;
      assignActionMode();
    } catch(e){
      EsToast.showError(e.toString());
    }
  }

  Future<void> unfriend() async {
    try {
      await FriendRequestRepo().delete(friendRequest.value!.id!);
      friendRequest.value = null;
      assignActionMode();
    } catch(e){
      EsToast.showError(e.toString());
    }
  }
}