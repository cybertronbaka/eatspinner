import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/caches/_all.dart';
import 'package:eatspinner/models/profile/profile.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uuid/uuid.dart';


FormGroup _createFormGroup([Profile? profile]){
  return fb.group({
    'id': [profile?.id, Validators.required],
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

  Future<void> uploadPhoto(XFile image, String type) async {
    try{
      final controlName = '${type}_url';
      Map<String, dynamic> profileJson = profile.value!.toJson();
      final photoUrl = profileJson[controlName];
      if(photoUrl != null && photoUrl != ''){
        final (bucket, path) = StorageUtils.getBucketAndPath(photoUrl);
        await StorageRepo().delete(path, bucket: bucket, throwError: false);
      }

      final uuid = const Uuid().v1();
      final fileName = '${supabase.auth.currentUser!.id}_${type}_$uuid.${image.path.split('.').last}';
      final uploadPath = '${type}s';
      final url = await StorageRepo().upload(image.path, fileName, uploadPath);
      profileJson[controlName] = url;
      profile.value = await cache.update(Profile.fromJson(profileJson));
      formGroup.value!.control(controlName).updateValue(url);
      print('Uploading done');
      EsToast.showSuccess('Image uploaded successfully!');
    } catch(e, stkTrc){
      EsToast.showError(e.toString(), stkTrc);
    }
  }

  Future<void> save() async {
    isFetching.value = true;
    try{
      profile.value = await cache.update(Profile.fromJson(formGroup.value!.value));
      isFetching.value = false;
      EsToast.showSuccess('Profile updated successfully!');
    } catch(e, stkTrc){
      isFetching.value = false;
      EsToast.showError(e.toString(), stkTrc);
    }
  }
}