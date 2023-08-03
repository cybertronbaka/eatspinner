import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';

class MapControlsPluginOption extends LayerOptions {
  final double minZoom;
  final double maxZoom;
  final double padding;
  final Alignment alignment;
  final Color? zoomInColor;
  final Color? zoomInColorIcon;
  final Color? zoomOutColor;
  final Color? zoomOutColorIcon;
  final IconData zoomInIcon;
  final IconData zoomOutIcon;
  final String? fullScreenRoute;

  MapControlsPluginOption({
    Key? key,
    this.minZoom = 1,
    this.maxZoom = 18,
    this.padding = 8.0,
    this.alignment = Alignment.topRight,
    this.zoomInColor,
    this.zoomInColorIcon,
    this.zoomInIcon = Icons.zoom_in,
    this.zoomOutColor,
    this.zoomOutColorIcon,
    this.zoomOutIcon = Icons.zoom_out,
    this.fullScreenRoute,
    Stream<void>? rebuild,
  }) : super(key: key, rebuild: rebuild);
}

class MapControlsPlugin implements MapPlugin {
  @override
  Widget createLayer(
      LayerOptions options, MapState mapState, Stream<void> stream) {
    if (options is MapControlsPluginOption) {
      return MapControlsWidget(options, mapState, stream);
    }
    throw Exception('Unknown options type for ZoomButtonsPlugin: $options');
  }

  @override
  bool supportsLayer(LayerOptions options) {
    return options is MapControlsPluginOption;
  }
}

class MapControlsWidget extends StatelessWidget {
  final MapControlsPluginOption pluginOption;
  final MapState map;
  final Stream<void> stream;
  final FitBoundsOptions options =
  const FitBoundsOptions(padding: EdgeInsets.all(12));

  MapControlsWidget(this.pluginOption, this.map, this.stream)
      : super(key: pluginOption.key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: pluginOption.alignment,
      child: Card(
        margin: EdgeInsets.all(pluginOption.padding),
        child: Padding(
          padding: EdgeInsets.all(pluginOption.padding),
          child: SizedBox(
            height: 30,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                    onTap: (){
                      final bounds = map.getBounds();
                      final centerZoom = map.getBoundsCenterZoom(bounds, options);
                      var zoom = centerZoom.zoom + 1;
                      if (zoom > pluginOption.maxZoom) {
                        zoom = pluginOption.maxZoom;
                      }
                      map.move(centerZoom.center, zoom,
                          source: MapEventSource.custom);
                    },
                    child: Icon(pluginOption.zoomInIcon,
                        color: pluginOption.zoomInColorIcon ??
                            IconTheme.of(context).color)
                ),
                const SizedBox(width: 10),
                GestureDetector(
                    onTap: (){
                      final bounds = map.getBounds();
                      final centerZoom = map.getBoundsCenterZoom(bounds, options);
                      var zoom = centerZoom.zoom - 1;
                      if (zoom < pluginOption.minZoom) {
                        zoom = pluginOption.minZoom;
                      }
                      map.move(centerZoom.center, zoom,
                          source: MapEventSource.custom);
                    },
                    child: Icon(pluginOption.zoomOutIcon,
                        size: 15,
                        color: pluginOption.zoomOutColorIcon ??
                            IconTheme.of(context).color)
                ),
                shouldShowFullscreenButton ? const SizedBox(width: 10) : Container(),
                shouldShowFullscreenButton ? GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed(pluginOption.fullScreenRoute!);
                    },
                    child: Icon(Icons.fullscreen_outlined,
                        color: pluginOption.zoomOutColorIcon ??
                            IconTheme.of(context).color)
                ) : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get shouldShowFullscreenButton {
    return pluginOption.fullScreenRoute != null && pluginOption.fullScreenRoute!.isNotEmpty;
  }
}