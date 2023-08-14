import 'package:eatspinner/repos/auth_repo.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

FormGroup _createFormGroup(){
  return fb.group({
    'email': ['', Validators.required],
    'password': ['', Validators.required]
  });
}

class LoginController extends GetxController {
  FormGroup formGroup = _createFormGroup();
  Rx<bool> isLoggingIn = false.obs;

  Future<void> login() async {
    isLoggingIn.value = true;
    final email = formGroup.control('email').value;
    final password = formGroup.control('password').value;
    try {
      await AuthRepo().signIn(SignInParams(email: email, password: password));
      EsToast.showSuccess('Logged in successfully');
      isLoggingIn.value = false;
    }catch(e){
      isLoggingIn.value = false;
      if(e.toString().contains('Failed host lookup')){
        EsToast.showError('Something went wrong in the server!');
        return;
      }
      EsToast.showError('Invalid email or password');
    }
  }

  void reset(){
    formGroup.updateValue(_createFormGroup().value);
    formGroup.markAsPristine();
    isLoggingIn.value = false;
  }
}