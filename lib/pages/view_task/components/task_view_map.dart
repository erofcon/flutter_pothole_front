import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../models/task_response_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/map_zoom_buttons.dart';
import '../view_task_provider_data.dart';



class Map extends StatelessWidget {
  const Map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskResponseModel model = WatchContext(context).watch<ViewTaskDate>().task!;

    return FlutterMap(
      options: MapOptions(
        enableScrollWheel: false,
        center: LatLng(model.latitude, model.longitude),
        zoom: 9.0,
        plugins: [
          ZoomButtonsPlugin(),
        ],
        // onTap: _handleTap,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://a.tile.openstreetmap.de/{z}/{x}/{y}.png',
        ),
        MarkerLayerOptions(markers: [
          Marker(
            point: LatLng(model.latitude, model.longitude),
            builder: (ctx) =>
            const Icon(Icons.location_on, size: 50.0, color: Colors.indigo),
          )
        ]),
        // MarkerLayerOptions(markers: markers)
      ],
      nonRotatedLayers: [
        ZoomButtonsPluginOption(
            minZoom: 4,
            maxZoom: 15,
            mini: true,
            padding: defaultPadding,
            alignment: Alignment.bottomRight)
      ],
    );
  }
}