 // @dart=2.9
import 'package:finalproject/Register.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smile Teeth & Pharma',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: Register()
    );
  }
}
