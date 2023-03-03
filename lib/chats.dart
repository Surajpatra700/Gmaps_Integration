// ignore_for_file: prefer_const_constructors

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage("https://unsplash.it/900/1600"),fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.deepPurple, BlendMode.softLight)),
          ),
          child: Center(
            child: AnimatedTextKit(animatedTexts: [
              FadeAnimatedText("Flutter",duration: Duration(seconds: 4),textStyle: TextStyle(fontSize: 50,fontWeight: FontWeight.bold)),
               FadeAnimatedText("Developer",duration: Duration(seconds: 4),textStyle: TextStyle(fontSize: 50,fontWeight: FontWeight.bold)),           
            ]),
          ),
        ),
    );
  }
}