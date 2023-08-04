import 'package:eatspinner/repos/_all.dart';
import 'package:flutter/material.dart';
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

  Future<void> fetchMany() async {
    isFetching.value = true;
    while(!context.mounted) {}
    PlaceRepo().fetchMany().then((value){
      places.value = value;
      isFetching.value = false;
    }).catchError((error){
      isFetching.value = false;
    });
  }


  Future<void> search(String q) async {
    isFetching.value = true;
    if(q.isEmpty) fetchMany();

    try{
      final res = await PlaceRepo().search(q);
      places.value = res;
      isFetching.value = false;
    }catch(e){
      isFetching.value = false;
      rethrow;
    }
  }

  Future<void> deletePlace(int id) async {
    await PlaceRepo().delete(id);
    await fetchMany();
  }
}