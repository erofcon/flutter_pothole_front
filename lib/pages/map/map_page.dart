import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 5.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://a.tile.openstreetmap.de/{z}/{x}/{y}.png',

        ),
      ],
    );
  }
}
