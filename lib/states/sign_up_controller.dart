import 'package:eatspinner/repos/auth_repo.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

FormGroup _createFormGroup(){
  return fb.group({
    'email': ['', Validators.required, Validators.email],
    'password': ['', Validators.required],
    'name': ['', Validators.required],
    'age': [15, Validators.required],
    'gender': ['', Validators.required],
  });
}

class SignUpController extends GetxController {
  FormGroup formGroup = _createFormGroup();
  Rx<bool> isSigningUp = false.obs;

  Future<void> signUp() async {
    isSigningUp.value = true;
    try {
      await AuthRepo().signUp(SignUpParams(
        email: formGroup.control('email').value,
        password: formGroup.control('password').value,
        name: formGroup.control('name').value,
        age: formGroup.control('age').value,
        gender: formGroup.control('gender').value
      ));
      EsToast.showSuccess('Signed Up successfully');
      isSigningUp.value = false;
    }catch(e){
      isSigningUp.value = false;
      EsToast.showError(e.toString());
    }
  }

  void reset(){
    formGroup.updateValue(_createFormGroup().value);
    formGroup.markAsPristine();
    isSigningUp.value = false;
  }
}