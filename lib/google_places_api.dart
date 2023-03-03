import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApiScreen extends StatefulWidget {
  const GooglePlacesApiScreen({super.key});

  @override
  State<GooglePlacesApiScreen> createState() => _GooglePlacesApiScreenState();
}

class _GooglePlacesApiScreenState extends State<GooglePlacesApiScreen> {
  final searchController = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = "12345";
  List<dynamic> _placesList = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(searchController.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyBtUNhipVoejwBOi4vZ9ZkGGC2l7zV2YeE"; // gmap project API key
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json'; //this link gets the request from the application & sends the response
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken'; // ? is added for query parameters
    // Query parameter are defined set of parameters attached to the end of a url. They are extensions of the URL that are used to help define specific content or actions based on the data being passed.
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    // print('data');
    // print(data);
    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Search Place Api"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            controller: searchController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Search places with name",
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _placesList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async{
                        List<Location> locations = await locationFromAddress(_placesList[index]['description']);
                        print(locations.last.latitude);
                        print(locations.last.longitude);
                      },
                      title: Text(_placesList[index]['description']),
                    );
                  }))
        ],
      ),
    );
  }
}
