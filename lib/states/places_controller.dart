import 'package:eatspinner/caches/_all.dart';
import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

FormGroup _createFormGroup(){
  return fb.group({
    'query': [''],
  });
}

class PlacesController extends GetxController{
  PlacesController();

  FormGroup formGroup = _createFormGroup();
  RxList places = RxList([]);
  Rx<bool> isFetching = false.obs;
  PlacesControllerCache cache = PlacesControllerCache.initialize();

  void reset([bool loadAll = false]){
    formGroup = _createFormGroup();
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
    try {
      final value = await cache.getAll();
      places.value = value;
    } catch(e){
      EsToast.showError(e.toString());
    } finally {
      isFetching.value = false;
    }
  }


  Future<void> search(String q) async {
    isFetching.value = true;
    if(q.isEmpty) return fetchMany();

    try {
      final res = await cache.search(q);
      places.value = res;
    } catch(e){
      EsToast.showError(e.toString());
    } finally {
      isFetching.value = false;
    }
  }

  Future<void> deletePlace(Place place) async {
    try {
      await cache.delete(place);
      await fetchMany();
      EsToast.showSuccess('Place Deleted Successfully');
    } catch(e){
      EsToast.showError(e.toString());
    }
  }
}