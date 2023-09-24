// ignore_for_file: prefer_const_constructors, avoid_print, use_function_type_syntax_for_parameters, non_constant_identifier_names, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_notes/auth/home/addcategory.dart';
import 'package:flutter_application_notes/auth/home/homepage.dart';
import 'package:flutter_application_notes/auth/home/notes.dart';
import 'package:flutter_application_notes/auth/home/viewnote.dart';
import 'package:flutter_application_notes/auth/login.dart';
import 'package:flutter_application_notes/auth/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null ? Homepage() : Login(),
      routes: {
        "Login": (context) => Login(),
        "Register": (context) => Register(),
        "Homepage": (context) => Homepage(),
        "AddCategory": (context) => AddCategory(),
        "Notes": (context) => Notes(),
        "ViewNote": (context) => ViewNote(),
      },
    );
  }
}
