import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapViewWidget extends StatefulWidget {
  final LatLng location;
  final double zoom;
  const MapViewWidget({
    super.key,
    required this.location,
    this.zoom = 7
  });

  @override
  State<MapViewWidget> createState() => _MapViewWidgetState();
}

class _MapViewWidgetState extends State<MapViewWidget>{
  MapController controller = MapController();

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        height: 200,
        child: FlutterMap(
          mapController: controller,
          options: MapOptions(
            center: widget.location,
            zoom: widget.zoom,
            minZoom: 0,
            maxZoom: 19,
            keepAlive: true,
            plugins: [
              MapControlsPlugin(),
            ],
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 40,
                  height: 40,
                  point: widget.location,
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
        )
    );
  }
}