import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/caches/_all.dart';
import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/repos/auth_repo.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController{
  Rx<Profile?> profile = Rx(null);
  Rx<bool> isFetchingProfile = true.obs;
  Rx<bool> isLoggingOut = false.obs;
  final cache = MyProfileCache.initialize();

  Future<void> fetchProfile({bool force = false}) async {
    if(profile.value != null && !force) {
      final xProfile = cache.getOneFromCache(supabase.auth.currentUser!.id);
      if(xProfile != null){
        profile.value = xProfile;
        return;
      }
    }

    isFetchingProfile.value = true;
    try{
      profile.value = await cache.getOne(supabase.auth.currentUser!.id);
      isFetchingProfile.value = false;
    } catch(e){
      isFetchingProfile.value = false;
      EsToast.showError(e.toString());
    }
  }

  Future<bool> logout() async {
    isLoggingOut.value = true;
    try{
      isLoggingOut.value = false;
      await AuthRepo().signOut();
      return true;
    } catch(e){
      isLoggingOut.value = false;
      EsToast.showError(e.toString());
      return false;
    }
  }
}