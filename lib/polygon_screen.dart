import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({super.key});

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  Set<Polygon> _polygon = HashSet<Polygon>();

  List<LatLng> points = [
    LatLng(22.2456, 84.8138),
    LatLng(22.2418, 84.8187),
    LatLng(22.2535, 84.8165),
    LatLng(22.2456, 84.8138),
  ];

  final _bHockeyStadium = CameraPosition(
    target: LatLng(22.2456, 84.8138),
    zoom: 14,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(
      Polygon(polygonId: PolygonId("1"), points: points,fillColor: Colors.red.withOpacity(0.3),geodesic: true,strokeWidth: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _bHockeyStadium,
        polygons: _polygon,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
