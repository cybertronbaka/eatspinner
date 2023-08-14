import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationRepo {
  LocationRepo();

  Future<void> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled. Please enable the services');
    }  permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }  if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied, we cannot request permissions.');
    }

  }

  Future<LatLng> getCurrentPosition() async {
    await _handleLocationPermission();
    final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
    print('GOT POSITION: ${pos.latitude}, ${pos.longitude}');
    return LatLng(pos.latitude, pos.longitude);
  }
}