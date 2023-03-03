import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLngToAdress extends StatefulWidget {
  const ConvertLatLngToAdress({super.key});

  @override
  State<ConvertLatLngToAdress> createState() => _ConvertLatLngToAdressState();
}

class _ConvertLatLngToAdressState extends State<ConvertLatLngToAdress> {
  String stAddress = '', stAdd = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gmaps"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(stAddress),
              Text(stAdd),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  //Converting address to Cordinates
                  //final query = "1600 Amphiteatre Parkway, Mountain View";
                  List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
                  List<Placemark> placemarks = await placemarkFromCoordinates(21.448406, 83.9908066);
                  // Converting Cordinates to address
                  //final cordinates = new Coordinates(33.6992, 72.9744);

                  setState(() {
                    stAddress = locations.last.latitude.toString() +"  "+locations.last.longitude.toString();
                    stAdd = placemarks.reversed.last.locality.toString()+", "+placemarks.reversed.last.street.toString()+", "+placemarks.reversed.last.street.toString();
                    //stAddress = first.addressLine.toString();
                    //stAddress = first.countryCode.toString();
                    //stAddress = first.adminArea.toString();
                  });
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Center(child: Text("Convert")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}