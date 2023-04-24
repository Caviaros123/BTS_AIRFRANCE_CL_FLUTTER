import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  final controller = Get.put(LoginController());
  final showPassword = false.obs;


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: const Text('Air France PPE'),
        // ),
        body: Container(
          margin: const EdgeInsets.only(left: 100, right: 100, top: 0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo air france
                Center(
                  child: Column(

                    children: [
                      Image.asset('assets/Air_France_Logo.png', width: 400,
                        height: 100,
                        fit: BoxFit.contain,)
                    ],
                  ),
                ),
                // email
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: TextFormField(
                    controller: controller.emailController.value,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // password
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: TextFormField(
                    controller: controller.passwordController.value,
                    obscureText: !showPassword.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(icon: Icon(
                          showPassword.value ? Icons.visibility : Icons
                              .visibility_off
                      ), onPressed: () {
                        print('show password');
                        showPassword.value = !showPassword.value;
                      }),
                    ),
                  ),
                ),
                // button login
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      // check on key press: enter
                      if (formKey.currentState!.validate()) {
                        await controller.login();
                      } else {
                        Get.defaultDialog(
                            title: 'Erreur',
                            middleText: "Veuillez remplir tous les champs",
                            textConfirm: 'OK',
                            onConfirm: () {
                              Get.back();
                            }
                        );
                      }
                    },
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator.adaptive()
                        : const Text('Login'),
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    });
  }
}
