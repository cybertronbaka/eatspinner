import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:reactive_forms/reactive_forms.dart';

FormGroup _createFormGroup([Place? place]){
  return fb.group({
    'id': FormControl<int>(value: place?.id),
    'name': [place?.name ?? '', Validators.required],
    'description': [place?.description ?? ''],
    'lat': [place?.lat ?? 0.0, Validators.required],
    'lon': [place?.lon ?? 0.0,  Validators.required],
    'rating': [place?.rating ?? 0.0, Validators.required, Validators.min(0), Validators.max(5)],
    'creator_id': [place?.creatorId ?? '']
  });
}

class AddEditPlaceController extends GetxController{
  Rx<double> stars = 0.0.obs;
  Rx<FormGroup> formGroup = _createFormGroup().obs;
  Rx<bool> isSaving = false.obs;
  Rx<bool> isFetching = false.obs;

  void reset([int? id]){
    if(id != null) {
      isFetching.value = true;
      PlaceRepo().fetchOne(id).then((value){
        // TODO: Better to redirect to exception page.
        if(value == null) throw Exception('This should no happen! Place fetched is not there!');

        formGroup.value = _createFormGroup(value);
        stars.value = value.rating ?? 0.0;
        isFetching.value = false;
      }).catchError((e){
        // TODO: Add Toast
        formGroup.value = _createFormGroup();
        isFetching.value = false;
      });
    } else {
      formGroup.value = _createFormGroup();
    }
    stars.value = 0.0;
    isSaving.value = false;
  }

  Future<Place?> save() async {
    if(isSaving.isTrue) throw Exception('Already saving!');

    isSaving.value = true;
    Place place = Place.fromJson(formGroup.value.value);
    final res = await PlaceRepo().save(place);
    isSaving.value = false;
    return res;
  }

  void onMarkerPlaced(LatLng latLng){
    formGroup.value.control('lat').updateValue(latLng.latitude);
    formGroup.value.control('lon').updateValue(latLng.longitude);
  }

  void onRatingChanged(double v){
    stars.value = v;
    formGroup.value.control('rating').updateValue(v);
  }
}
