// ignore_for_file: unused_field, unused_element, use_super_parameters

//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'homepage.dart';

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
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0F0B1B),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}








