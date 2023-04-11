import 'dart:convert';

import 'package:airfrance/controllers/profil_controller.dart';
import 'package:airfrance/views/auth/login.dart';
import 'package:airfrance/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // load appif(GetStorage().hasData('login')){
  //   //   Get.put(ProfileController());
  //   // }
  //

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

   final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Air France PPE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: box.hasData('login') ? HomeScreen() : LoginScreen()
    );
  }
}