import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

FormGroup _createFormGroup(){
  return fb.group({
    'id': FormControl<int>(value: null),
    'name': ['', Validators.required],
    'description': [''],
    'lat': [0.0, Validators.required],
    'lon': [0.0, Validators.required],
    'rating': [0.0, Validators.required, Validators.min(0), Validators.max(5)],
    'creator_id': ['']
  });
}

class AddEditPlaceController extends GetxController{
  Rx<double> stars = 0.0.obs;
  FormGroup formGroup = _createFormGroup();
  Rx<bool> isSaving = false.obs;

  void reset(){
    formGroup = _createFormGroup();
    stars.value = 0.0;
    isSaving.value = false;
  }

  Future<Place?> save() async {
    if(isSaving.isTrue) throw Exception('Already saving!');

    isSaving.value = true;
    Place place = Place.fromJson(formGroup.value);
    final res = await PlaceRepo().save(place);
    isSaving.value = false;
    return res;
  }
}
