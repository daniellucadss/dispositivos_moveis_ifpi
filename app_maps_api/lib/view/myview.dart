import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  //texto contendo a localização atual
  String _localizacao = 'Casa';

  Future<void> _changeLocation() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
        CameraUpdate.newCameraPosition(_localizacao == "Casa" ? _IFPI : _casa));
    setState(() {
      _localizacao = _localizacao == "Casa" ? "IFPI" : "Casa";
    });
  }

  static const CameraPosition _casa = CameraPosition(
    target: LatLng(-5.093708656214135, -42.75412754927936),
    zoom: 18,
  );

  static const CameraPosition _IFPI = CameraPosition(
    target: LatLng(-5.088337, -42.81065),
    zoom: 18,
  );

  // Future<void> _getPermission() async {
  //   await Geolocator.requestPermission();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _getPermission();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: _casa,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.hybrid,
          markers: {
            const Marker(
              markerId: MarkerId('1'),
              position: LatLng(-5.093708656214135, -42.75412754927936),
              infoWindow: InfoWindow(title: 'Casa'),
            ),
            const Marker(
              markerId: MarkerId('2'),
              position: LatLng(-5.088408, -42.81065),
              infoWindow: InfoWindow(title: 'IFPI'),
            ),
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _changeLocation,
        label: const Text('Simboraaaaa!!!'),
        icon: const Icon(Icons.change_circle),
      ),
    );
  }
}
