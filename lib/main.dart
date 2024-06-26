import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:tapnbuy/screens/seller/dashboard_screen.dart';
import 'package:tapnbuy/slider.dart';
import 'package:tapnbuy/splash.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tap N Buy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.black,
          secondary: Colors.black
        ),
      ),
      home:splash(),
    );
  }
}
