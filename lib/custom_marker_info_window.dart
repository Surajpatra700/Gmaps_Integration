import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  final customInfoWindowController = CustomInfoWindowController();

  //Completer<GoogleMapController> _controller = Completer();

  List<Marker> _marker = <Marker>[];
  List<LatLng> _latlng = [
    LatLng(22.2418, 84.8187),
    LatLng(22.2535, 84.8165),
  ];

  final _bHockeyStadium = CameraPosition(
    target: LatLng(22.2456, 84.8138),
    zoom: 14,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latlng.length; i++) {
      _marker.add(
        Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: _latlng[i],
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.8),
                ),
                child: Column(
                  children: [
                    Image.network("https://unsplash.it/200/300",fit: BoxFit.cover,),
                  ],
                ),
              ),
              //Text("Suraj patra"),
              _latlng[i],
            );
          },
          //infoWindow: ,
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Info Window"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _bHockeyStadium,
            markers: Set<Marker>.of(_marker),
            onTap: (position) {
              customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: customInfoWindowController,
            height: 300,
            width: 200,
            offset: 10,
          ),
        ],
      ),
    );
  }
}
