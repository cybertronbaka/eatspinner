import 'package:eatspinner/repos/location_repo.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget{
  final void Function(LatLng latLng)? onMarkerPlaced;
  const MapWidget({
    super.key,
    this.onMarkerPlaced
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget>{
  late MyMapController stateController;
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    stateController = Get.find<MyMapController>();
    mapController = MapController();
    _getCurrentPosition();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultLatLng = LatLng(27.420782, 90.482382);

    return SizedBox(
      height: 200,
      child: Obx(()=> FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: stateController.location.value ?? defaultLatLng,
          zoom: 7,
          minZoom: 0,
          maxZoom: 19,
          keepAlive: true,
          onTap: (tapPos, location){
            stateController.location.value = location;
            mapController.move(location, 17);
            if(widget.onMarkerPlaced != null) widget.onMarkerPlaced!(location);
          },
          plugins: [
            MapControlsPlugin(),
          ],
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.app',
          ),
          if(stateController.location.value != null) MarkerLayerOptions(
              markers: [
                Marker(
                    width: 40,
                    height: 40,
                    point: stateController.location.value!,
                    anchorPos: AnchorPos.align(AnchorAlign.top),
                    builder: (context){
                      return const Icon(
                        Icons.location_on,
                        size: 40,
                        color: Colors.red,
                      );
                    }
                )
              ]
          ),
        ],
        nonRotatedLayers: [
          MapControlsPluginOption(
              minZoom: 4,
              maxZoom: 19,
              padding: 10,
              zoomInIcon: Icons.add,
              zoomOutIcon: Icons.remove,
              alignment: Alignment.bottomRight,
          ),
        ],
        // Keeping the following attribution just in case of legal countermeasures.
        nonRotatedChildren: [
          AttributionWidget(
            attributionBuilder: (BuildContext context) {
              return Align(
                alignment: Alignment.bottomRight,
                child: ColoredBox(
                  color: const Color(0xCCFFFFFF),
                  child: GestureDetector(
                    child: const Padding(
                      padding: EdgeInsets.all(3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MouseRegion(
                            cursor: MouseCursor.defer,
                            child: Text(
                              '© OpenStreetMap',
                              style: TextStyle(color: Color(0xFF0078a8),
                            ),
                          ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ))
    );
  }

  Future<void> _getCurrentPosition() async {
    await LocationRepo().getCurrentPosition()
        .then((LatLng? latLng) {
      if(latLng == null) return;

      print('Position: ${latLng.latitude}, ${latLng.longitude}');
      setState(() {
        stateController.location.value = latLng;
        mapController.move(latLng, 17);
        if(widget.onMarkerPlaced != null) widget.onMarkerPlaced!(latLng);
      });
    }).catchError((e) {
      final userLocation = LatLng(27.4716, 89.6386);
      stateController.location.value = userLocation;
      mapController.move(userLocation, 17);
      EsToast.showError(e.toString());
    });
  }
}