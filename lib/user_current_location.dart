// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocationScreen extends StatefulWidget {
  const GetUserCurrentLocationScreen({super.key});

  @override
  State<GetUserCurrentLocationScreen> createState() =>
      _GetUserCurrentLocationScreenState();
}

class _GetUserCurrentLocationScreenState
    extends State<GetUserCurrentLocationScreen> {
  Completer<GoogleMapController> _controller = Completer();

  final _kGooglePlex = CameraPosition(
    target: LatLng(22.203500, 84.654690),
    zoom: 14,
  );

  //List<Marker> _marker = [];
  List<Marker> _marker = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(22.203500, 84.654690),
      infoWindow: InfoWindow(title: "My Location"),
    ),
  ];

  Future getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  loadData() {
    getUserCurrentLocation().then((value) async {
      // print('my current Location');
      // print(value.latitude.toString() + " " + value.longitude.toString());

      _marker.add(
        Marker(
          markerId: MarkerId("2"),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(
            title: "My Current Location",
          )));
      final cameraPosition = CameraPosition(
        //zoom: 10,
        target: LatLng(value.latitude, value.longitude),
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _marker.addAll(_list);
  // }

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
          onPressed: () {},
          child: Icon(Icons.local_activity),
        ),
      ),
    );
  }
}

