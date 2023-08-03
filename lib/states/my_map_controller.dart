import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MyMapController extends GetxController{
  Rx<LatLng?> location = LatLng(27.4716, 89.6386).obs;
  Rx<MapController> smallController = MapController().obs;

  void reset([LatLng? loc]){
    if(loc != null) location.value = loc;
    smallController.value = MapController();
  }
}