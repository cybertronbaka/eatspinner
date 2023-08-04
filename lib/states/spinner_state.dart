import 'dart:async';
import 'dart:math';

import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/repos/_all.dart';
import 'package:eatspinner/repos/auth_repo.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';

class SpinnerController extends GetxController{
  BuildContext context;
  SpinnerController(this.context);

  RxList places = RxList([]);
  Rx<StreamController<int>> fortuneStream = StreamController<int>().obs;
  Rx<int> selectedIndex = 0.obs;
  Rx<bool> isSpinning = false.obs;
  Rx<bool> isFetching = false.obs;
  Rx<bool> canBeSpun = true.obs;
  Rx<bool> isLoggingOut = false.obs;

  void spin(){
    if(isSpinning.isTrue) return;

    onSpinStart();
    List<WeightedItem> weightedItems = places.value.mapIndexed((i, e){
      final weight = (0.4 * (i + 1)) + ((e.rating ?? 0.0) * 0.6);
      print('WEIGHT FOR ${e.name} is $weight');
      return WeightedItem<Place>(e, weight);
    }).toList();
    selectedIndex.value = WeightedRandom.generate(weightedItems);
    fortuneStream.value.add(selectedIndex.value);
    print('Selected is ${places.value[selectedIndex.value].name}');
  }

  void reset(){
    fortuneStream.value = StreamController<int>();
    selectedIndex.value = 0;
    isSpinning.value = false;
    isFetching.value = true;
    canBeSpun.value = true;
    fetchNearby();
  }

  void fetchNearby(){
    LocationRepo(context).getCurrentPosition().then((value){
      if(value == null) {
        return;
      }
      PlaceRepo().searchNearby(value).then((value){
        if(value.isEmpty){
          places.value = [Place(name: 'None'), Place(name: 'None')];
          canBeSpun.value = false;
        } else if (value.length == 1) {
          places.value = [value.first, value.first];
          canBeSpun.value = false;
        } else {
          places.value = value;
        }
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

  void showSelectedPlace(BuildContext context){
    showDialog(context: context, builder: (context){
      return AlertDialog(
          title: Text(places.value[selectedIndex.value].name ?? '---'),
          content: SizedBox(
              height: 500,
              width: 500,
              child: PlaceCard(
                place: places.value[selectedIndex.value],
                viewOnly: true,
              )
          )
      );
    });
  }

  Future<void> logout() async {
    isLoggingOut.value = true;
    try {
      await AuthRepo().signOut();
      isLoggingOut.value = false;
    } catch(e){
      isLoggingOut.value = false;
      rethrow;
    }
  }
}