import 'package:eatspinner/repos/auth_repo.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

FormGroup _createFormGroup(){
  return fb.group({
    'email': ['', Validators.required, Validators.email],
  });
}

class ForgotPasswordController extends GetxController {
  FormGroup formGroup = _createFormGroup();
  Rx<bool> isPending = false.obs;

  Future<void> resetPassword() async {
    isPending.value = true;
    final email = formGroup.control('email').value;
    try {
      await AuthRepo().resetPassword(email);
      isPending.value = false;
    }catch(e){
      isPending.value = false;
      rethrow;
    }
  }

  void reset(){
    formGroup.updateValue(_createFormGroup().value);
    formGroup.markAsPristine();
    isPending.value = false;
  }
}