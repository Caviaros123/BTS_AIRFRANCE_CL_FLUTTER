


import 'dart:convert';

import 'package:airfrance/controllers/profil_controller.dart';
import 'package:airfrance/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';
import '../providers/db_service.dart';

class LoginController extends GetxController{
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController = TextEditingController().obs;

  final loginFormKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    super.dispose();
  }

  //login
  Future login() async {
    isLoading(true);
    try {
      final data = {
        'email': emailController.value.text,
        'mdp': passwordController.value.text,
        'seConnecter': 'seConnecter',
        'from': 'api'
      };

      final res = await ApiProvider().postData('connexion.php', data);
      final body = jsonDecode(res.body)['data'];

      printInfo(info: 'DB CONN LOGIN====>  : $body') ;

      if (res.statusCode == 200) {
        box.write('login', body);
        printInfo(info: 'DB CONN STORAGE: ${box.read('login')}' );
        ProfileController.to.user.value = User.fromJson(body);
        Get.offAll(() => HomeScreen(), arguments: body);
      }

    } catch (e) {
      Get.defaultDialog(
          title: 'Erreur',
          middleText: "$e",
          textConfirm: 'OK',
          onConfirm: () {
            Get.back();
          });
    } finally {
      isLoading(false);
    }
  }
}