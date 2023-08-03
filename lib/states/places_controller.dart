import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:eatspinner/repos/location_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

FormGroup _createFormGroup(){
  return fb.group({
    'query': [''],
  });
}

class PlacesController extends GetxController{
  BuildContext context;
  PlacesController(this.context);

  FormGroup formGroup = _createFormGroup();
  RxList places = RxList([]);
  Rx<bool> isFetching = false.obs;

  void reset([bool loadAll = false]){
    formGroup = _createFormGroup();
    if(loadAll) {
      initList();
    }
  }

  void initList(){
    final String? q = formGroup.control('query').value;
    if(q != null && q.isNotEmpty ){
      search(q);
      return;
    }

    fetchMany();
  }

  void fetchMany(){
    isFetching.value = true;
    PlaceRepo().fetchMany().then((value){
      places.value = value;
      isFetching.value = false;
    }).catchError((error){
      // TODO: DO something here!
      isFetching.value = false;
    });
  }


  void search(String q){
    isFetching.value = true;
    PlaceRepo().search(q).then((value){
      places.value = value;
      isFetching.value = false;
    }).catchError((error){
      // TODO: DO something here!
      isFetching.value = false;
    });
  }
}