import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/caches/_all.dart';
import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/pages/profile/_all.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:eatspinner/repos/friend_request_repo.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  late String uid;

  Rx<Profile?> profile = Rx(null);
  Profile? myProfile;
  Rx<bool> isFetching = true.obs;
  Rx<FriendRequest?> friendRequest = Rx(null);
  Rx<ProfileMainActionMode> actionMode = Rx(ProfileMainActionMode.none);

  final cache = ProfilesCache.initialize();
  final myProfileCache = MyProfileCache.initialize();

  void init({required String uid}){
    this.uid = uid;
    myProfile = myProfileCache.getOneFromCache(supabase.auth.currentUser!.id);
  }

  Future<void> fetchProfile() async {
    isFetching.value = true;
    try{
      profile.value = await cache.getOne(uid);
      isFetching.value = false;
      if(supabase.auth.currentUser!.id == uid) return;
      await fetchFriendRequest();
      assignActionMode();
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
        if(friendRequest.value!.receiverUid! == supabase.auth.currentUser!.id){
          actionMode.value = ProfileMainActionMode.rejectedByMe;
        } else {
          actionMode.value = ProfileMainActionMode.rejectedByOther;
        }
      }
    } else {
      actionMode.value = ProfileMainActionMode.addToContact;
    }
  }

  Future<bool> fetchFriendRequest() async {
    friendRequest.value = await FriendRequestRepo().fetchOneByUid(uid);
    return friendRequest.value != null;
  }

  Future<FriendRequest?> addToContact() async {
    try {
      final res =  await FriendRequestRepo().create(FriendRequest(senderUid: supabase.auth.currentUser!.id, receiverUid: uid));
      friendRequest.value = res;
      assignActionMode();
      await NotificationRepo().sendNotification(OneSignalNotification(
        uidList: [uid],
        heading: 'Someone sent you a friend request.',
        contents: '${myProfile?.name ?? 'Someone'} is requesting to add you as a friend',
        appUrl: Routes.profile.replaceAll(':id', supabase.auth.currentUser!.id)
      ));
      return res;
    } catch(e){
      EsToast.showError(e.toString());
      return null;
    }
  }

  Future<FriendRequest?> acceptRequest() async {
    try {
      if(friendRequest.value == null) return null;

      final res = await FriendRequestRepo().update(
        friendRequest.value!.copyWith(accepted: true)
      );
      friendRequest.value = res;
      assignActionMode();
      await NotificationRepo().sendNotification(OneSignalNotification(
          uidList: [uid],
          heading: 'A friend request was accepted',
          contents: '${myProfile?.name ?? 'Someone'} accepted your friend request',
          appUrl: Routes.profile.replaceAll(':id', supabase.auth.currentUser!.id)
      ));
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
      await NotificationRepo().sendNotification(OneSignalNotification(
        uidList: [uid],
        heading: 'A friend request was rejected',
        contents: '${myProfile?.name ?? 'Someone'} rejected your friend request',
        appUrl: Routes.profile.replaceAll(':id', supabase.auth.currentUser!.id)
      ));
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
      // TODO: See if sending a notification here is valid or not
    } catch(e){
      EsToast.showError(e.toString());
    }
  }
}