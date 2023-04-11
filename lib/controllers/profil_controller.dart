import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';
import '../providers/db_service.dart';
import '../views/home.dart';

class ProfileController extends GetxController {
  final isLoading = true.obs;

  // Profile controller to init
  static ProfileController get to => Get.find();

  final box = GetStorage();

  final Rx<User> user = User().obs;

  // text editing controllers
  final nameController = TextEditingController().obs;
  final firstnameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    printInfo(info: 'DB LOCAL STORAGE ====>>> ${box.read('login')}');
    user.value = User.fromJson(box.read('login'));
    nameController.value.text = user.value.name;
    firstnameController.value.text = user.value.firstname;
    emailController.value.text = user.value.email;
  }

  @override
  void dispose() {
    nameController.value.dispose();
    firstnameController.value.dispose();
    emailController.value.dispose();
    passwordController.value.dispose();
    confirmPasswordController.value.dispose();
    super.dispose();
  }

  Future updateProfile() async {
    isLoading(true);
    try {
      final data = {
        'nom': nameController.value.text,
        'prenom': firstnameController.value.text,
        'email': emailController.value.text,
        'password': passwordController.value.text,
        'confirmPassword': confirmPasswordController.value.text,
        'updateProfile': 'updateProfile',
        'from': 'api'
      };

      final res = await ApiProvider().postData('updateProfile.php', data);
      final body = jsonDecode(res.body);

      printInfo(info: 'DB CONN updateProfile: $body');

      if (res.statusCode == 200) {
        box.remove('login');
        box.write('login', jsonEncode(body));
        printInfo(info: 'DB CONN STORAGE: ${box.read('login')}');
        Get.delete<ProfileController>();
        Get.put(ProfileController());
        box.write('login', (value) => jsonEncode(body));
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

  Future logout() async {
    isLoading(true);
    try {
      final data = {
        'logout': 'logout',
        'from': 'api'
      };

      final res = await ApiProvider().postData('logout.php', data);
      final body = jsonDecode(res.body);

      printInfo(info: 'DB CONN logout: $body');

      if (res.statusCode == 200) {
        box.remove('login');
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
