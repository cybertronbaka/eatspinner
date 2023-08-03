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

  void fetchMany(){
    isFetching.value = true;
    PlaceRepo().fetchMany().then((value){
      places.value = value;
      isFetching.value = false;
    }).catchError((error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}'))
      );
      isFetching.value = false;
    });
  }


  void search(String q){
    isFetching.value = true;
    if(q.isEmpty) fetchMany();

    PlaceRepo().search(q).then((value){
      places.value = value;
      isFetching.value = false;
    }).catchError((error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}'))
      );
      isFetching.value = false;
    });
  }

  void deletePlace(int id){
    PlaceRepo().delete(id).then((value){
      fetchMany();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Place Removed Successfully'))
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}'))
      );
    });
  }
}