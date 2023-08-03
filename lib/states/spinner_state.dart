import 'dart:async';
import 'dart:math';

import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpinnerController extends GetxController{
  BuildContext context;
  SpinnerController(this.context);

  RxList places = RxList([]);
  Rx<StreamController<int>> fortuneStream = StreamController<int>().obs;
  Rx<int> selectedIndex = 0.obs;
  Rx<bool> isSpinning = false.obs;
  Rx<bool> isFetching = false.obs;

  void spin(){
    if(isSpinning.isTrue) return;

    onSpinStart();
    selectedIndex.value = Random().nextInt(places.length - 1);
    fortuneStream.value.add(selectedIndex.value);
    print('Selected is ${places[selectedIndex.value]}');
  }

  void reset(){
    fortuneStream.value = StreamController<int>();
    selectedIndex.value = 0;
    isSpinning.value = false;
    isFetching.value = true;
    fetchNearby();
  }

  void fetchNearby(){
    LocationRepo(context).getCurrentPosition().then((value){
      if(value == null) {
        return;
      }
      PlaceRepo().searchNearby(value).then((value){
        places.value = value;
        isFetching.value = false;
      }).catchError((error){
        // TODO: DO something here!
        isFetching.value = false;
      });
    });
  }

  void onSpinStart() {
    print('Spinning started!');
    isSpinning.value = true;
  }

  void onSpinDone(){
    print('Spinning Done!');
    isSpinning.value = false;
  }
}