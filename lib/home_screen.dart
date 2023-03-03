// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();

  final _kGooglePlex = CameraPosition(
    target: LatLng(22.203500, 84.654690),
    zoom: 14,
  );

  List<Marker> _marker = [];
  List<Marker> _list = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(22.203500, 84.654690),
      infoWindow: InfoWindow(title: "My Location"),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(20.775803, 84.637724),
      infoWindow: InfoWindow(title: "MahtabRoad"),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(45.596230,7.907500),
      infoWindow: InfoWindow(title: "Mt. Lauterbrunnen, Switzerland"),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: _kGooglePlex,
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(45.596230,7.907500),
                zoom: 14,
              ),
            ));
            setState(() {
              
            });
          },
          child: Icon(Icons.location_on_outlined),
        ),
      ),
    );
  }
}
