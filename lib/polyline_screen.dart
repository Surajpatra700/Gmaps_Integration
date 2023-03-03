import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  Completer<GoogleMapController> _controller = Completer();

  final _bHockeyStadium = CameraPosition(
    target: LatLng(22.2456, 84.8138),
    zoom: 14,
  );

  final Set<Marker> _marker = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> latlng = [
    LatLng(22.2456, 84.8138),
    LatLng(22.2418, 84.8187),
    LatLng(22.2535, 84.8165),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < latlng.length; i++) {
      _marker.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: latlng[i],
          infoWindow: InfoWindow(
            title: "Really cool place",
            snippet: "5 star Rating",
          ),
          icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {
        
      });
      _polyline.add(
      Polyline(polylineId: PolylineId("1"),
      points: latlng,
      color: Colors.orange,
      width: 4,
      ),

    );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _bHockeyStadium,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        //markers: _marker,
        polylines: _polyline,
      ),
    );
  }
}
