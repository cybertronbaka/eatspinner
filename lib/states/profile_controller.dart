import 'package:eatspinner/caches/_all.dart';
import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  final String uid;

  ProfileController({required this.uid});

  Rx<Profile?> profile = Rx(null);
  Rx<bool> isFetching = true.obs;

  final cache = ProfilesCache.initialize();

  Future<void> fetchProfile() async {
    isFetching.value = true;
    try{
      profile.value = await cache.getOne(uid);
      isFetching.value = false;
    } catch(e){
      isFetching.value = false;
      EsToast.showError(e.toString());
    }
  }
}