import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intern_task_todquest/part2/card.dart';
import 'package:intern_task_todquest/part3/screen1.dart';
import 'package:firebase_core/firebase_core.dart';

import 'part3/screen2.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false ,
      home:  LoginPage()
    );
  }
}
