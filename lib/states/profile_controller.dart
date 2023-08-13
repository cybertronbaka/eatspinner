import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/models/profile/profile.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  Rx<Profile?> profile = Rx(null);
  Rx<bool> isFetching = false.obs;

  void reset(){
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isFetching.value = true;
    try{
      profile.value = await ProfileRepo().fetchByUid(supabase.auth.currentUser!.id);
      isFetching.value = false;
    } catch(e){
      isFetching.value = false;
      rethrow;
    }
  }
}