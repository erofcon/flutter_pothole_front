import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapLocation extends StatefulWidget {
  const MapLocation({Key? key, required this.location}) : super(key: key);
  final Function(LatLng latLng) location;

  @override
  State<MapLocation> createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  late LocationPermission _locationPermission;
  late bool _serviceEnabled;

  List<LatLng> tappedPosition = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = tappedPosition.map((latLng) {
      return Marker(
        point: latLng,
        builder: (ctx) =>
            const Icon(Icons.location_on, size: 50.0, color: Colors.indigo),
      );
    }).toList();

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Theme.of(context).cardColor,
        ),
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(43.4898881, 43.603907),
            zoom: 9.0,
            onTap: _handleTap,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://a.tile.openstreetmap.de/{z}/{x}/{y}.png',
            ),
            MarkerLayerOptions(markers: markers)
          ],
        ),
        floatingActionButton: Builder(builder: (BuildContext context) {
          return FloatingActionButton(
              onPressed: () {
                _getCurrentPosition();
              },
              child: const Icon(Icons.location_on_outlined));
        }));
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    LatLng latLng = LatLng(position.latitude, position.longitude);

    _handleTap(null, latLng);
  }

  Future<bool> _handlePermission() async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      return false;
    }
    _locationPermission = await Geolocator.checkPermission();
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
      if (_locationPermission == LocationPermission.denied) {
        return false;
      }
    }

    if (_locationPermission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  void _handleTap(_, latLng) {
    widget.location(latLng);
    setState(() {
      tappedPosition.clear();
      tappedPosition.add(latLng);
    });
  }
}
