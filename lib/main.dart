import 'dart:html' as html;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyC5FT6x1bp8mlB4uCfaG2AcPuaKUoD7q7o",
        authDomain: "palcredits-1b837.firebaseapp.com",
        projectId: "palcredits-1b837",
        storageBucket: "palcredits-1b837.appspot.com",
        messagingSenderId: "33088222599",
        appId: "1:33088222599:web:4408143c1af0a61cca0f22",
        measurementId: "G-L4YDK15ZRW"),
  );
  html.window.onBeforeUnload.listen((html.Event e) {
    // Prompt the user to confirm leaving the page
    var confirmationMessage = 'Are you sure you want to leave this page?';
    (e as html.BeforeUnloadEvent).returnValue = confirmationMessage;

    // Cancel the event if the user chooses to stay on the page
    e.preventDefault();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pal Credit Admin Pannel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Login());
  }
}
