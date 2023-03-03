// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:design_app/convert_latlng_to_address.dart';
import 'package:design_app/custom_marker_info_window.dart';
import 'package:design_app/custom_marker_screen.dart';
import 'package:design_app/google_places_api.dart';
import 'package:design_app/home_screen.dart';
import 'package:design_app/polygon_screen.dart';
import 'package:design_app/user_current_location.dart';
import 'package:flutter/material.dart';
import 'package:design_app/chats.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: PolygonScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 2;

  // List<Widget> item = [
  //   Center(
  //     child: Text("Home page"),
  //   ),
  //   Center(
  //     child: Text("Search page"),
  //   ),
  //   Center(
  //     child: Text("File page"),
  //   ),
  //   Center(
  //     child: Text("Option page"),
  //   ),
  //   Center(
  //     child: Text("Contact page"),
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: Drawer(),
        extendBody: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Design App"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Chats"),
              Tab(text: "Status"),
              Tab(text: "Calls"),
              Tab(text: "Settings"),
            ]
          ),
          centerTitle: true,
        ),
         body: TabBarView(children: [
          ChatPage(),
          Center(child: Text("Status Page"),),
          Center(child: Text("Call Page"),),
          Center(child: Text("Settings Page"),),
         ]),
         //Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(image: NetworkImage("https://unsplash.it/900/1600"),fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.deepPurple, BlendMode.softLight)),
        //   ),
        //   child: Center(
        //     child: AnimatedTextKit(animatedTexts: [
        //       FadeAnimatedText("Flutter",duration: Duration(seconds: 4),textStyle: TextStyle(fontSize: 50,fontWeight: FontWeight.bold)),
        //        FadeAnimatedText("Developer",duration: Duration(seconds: 4),textStyle: TextStyle(fontSize: 50,fontWeight: FontWeight.bold)),           
        //     ]),
        //   ),
        // ),
        //Image.network(),
    
        bottomNavigationBar: CurvedNavigationBar(
            onTap: (index) => setState(() {
                  this.index = index;
                }),
            index: index,
            animationDuration: Duration(milliseconds: 500),
            backgroundColor: Colors.transparent,
            height: 60,
            //animationCurve: Curves.easeInCubic,
            color: Colors.deepPurple,
            items: [
              Icon(
                Icons.home,
                color: Colors.white,
              ),
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              Icon(
                Icons.chat_bubble,
                color: Colors.white,
              ),
              Icon(
                Icons.list,
                color: Colors.white,
              ),
              Icon(
                Icons.person,
                color: Colors.white,
              ),
            ]),
      ),
    );
  }
}
