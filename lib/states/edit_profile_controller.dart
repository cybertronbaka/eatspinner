import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/caches/_all.dart';
import 'package:eatspinner/models/profile/profile.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';


FormGroup _createFormGroup([Profile? profile]){
  return fb.group({
    'id': [profile?.id ?? '', Validators.required],
    'name': [profile?.name ?? '', Validators.required],
    'age': [profile?.age ?? 15, Validators.required, Validators.min(15)],
    'gender': [profile?.gender ?? 'Male', Validators.required],
    'email': [profile?.email ?? '', Validators.required],
    'bio': [profile?.bio ?? ''],
    'avatar_url': [profile?.avatarUrl ?? ''],
    'cover_url': [profile?.coverUrl ?? '']
  });
}

class EditProfileController extends GetxController{
  Rx<Profile?> profile = Rx(null);
  Rx<bool> isFetching = true.obs;
  Rx<FormGroup?> formGroup = Rx(_createFormGroup());
  MyProfileCache cache = MyProfileCache.initialize();

  void reset(){
    formGroup.value!.updateValue(_createFormGroup().value);
    formGroup.value!.markAsPristine();
  }

  Future<void> fetchProfile() async {
    isFetching.value = true;
    try{
      profile.value = await cache.getOne(supabase.auth.currentUser!.id);
      formGroup.value = _createFormGroup(profile.value);
      isFetching.value = false;
    } catch(e){
      isFetching.value = false;
      EsToast.showError(e.toString());
    }
  }
}