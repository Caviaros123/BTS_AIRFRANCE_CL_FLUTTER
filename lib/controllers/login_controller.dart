


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../providers/db_service.dart';
import '../routes/routes.dart';

class LoginController extends GetxController{
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController = TextEditingController().obs;

  final loginFormKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  final box = GetStorage();

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
      final body = jsonDecode(res.body);

       printInfo(info: 'DB CONN LOGIN====>  : $body') ;

      if (res.statusCode == 200 && body['status'] == 200) {
        box.write('login', body['data']);
        printInfo(info: 'DB CONN STORAGE: ${box.read('login')}' );
        // ProfileController.to.user.value = User.fromJson(body);
        Get.delete<LoginController>();
        return Get.offAndToNamed(Routes.home);
      }
    } catch (e) {
      Get.defaultDialog(
          title: 'Une erreur est survenue',
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