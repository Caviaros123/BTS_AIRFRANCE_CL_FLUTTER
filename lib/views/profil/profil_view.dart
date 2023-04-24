import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/profil_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  final isEditing = false.obs;

  @override
  Widget build(BuildContext context) {

    return _buildProfileTabView();
  }

  Widget _buildProfileTabView() {

    return Obx(()  {
        return Container(
            margin: const EdgeInsets.only(left: 200, right: 200, top: 20),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    elevation: 5,
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: const Text('Mon profil', style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),),
                          ),
                          // build inputs for profile:
                          // - nom
                          // if user is admin
                          isEditing.value ? Container(
                            height: Get.height / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller:
                                  controller.nameController.value,
                                  decoration: const InputDecoration(
                                    hintText: 'Nom',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                // - prenom
                                TextFormField(
                                  controller:
                                  controller.firstnameController.value,
                                  decoration: const InputDecoration(
                                    hintText: 'Prenom',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Rentrez votre prenom';
                                    }
                                    return null;
                                  },
                                ),
                                // - email
                                TextFormField(
                                  controller:
                                  controller.emailController.value,
                                  decoration: const InputDecoration(
                                    hintText: 'Email',
                                    border: OutlineInputBorder(),
                                  ),
                                ),

                                TextFormField(
                                  controller: controller.passwordController
                                      .value,
                                  obscureText: !controller.showPassword.value,
                                  decoration: InputDecoration(
                                    labelText: 'Mot de passe actuel',
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(icon: Icon(
                                        controller.showPassword.value ? Icons.visibility : Icons
                                            .visibility_off
                                    ), onPressed: () {
                                      controller.showPassword.value = !controller.showPassword.value;
                                    }),
                                  ),
                                ),
                                // submit button
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blueAccent,
                                    minimumSize: Size(double.infinity, 50),
                                  ),
                                  onPressed: () async {
                                   if(controller.passwordController.value.text.isNotEmpty){
                                     await controller.updateProfile();
                                   } else {
                                     Get.dialog( AlertDialog(
                                      title: const Text('Erreur'),
                                      content: const Text('Veuillez remplir tous les champs'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('Ok'),
                                        )
                                      ],
                                    ));
                                   }
                                  },
                                  child: controller.isLoading.value ? const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ) : const Text('Enregistrer'),
                                ),
                              ],
                            ),
                          ) : Container(
                              height: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      const Text('Nom: ', style: TextStyle(
                                          fontWeight: FontWeight.bold),),
                                      Text('${controller.user.value.name ?? ''}'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text('Prenom: ', style: TextStyle(
                                          fontWeight: FontWeight.bold),),
                                      Text(controller.user.value.firstname ?? ''),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text('Email: ', style: TextStyle(
                                          fontWeight: FontWeight.bold),),
                                      Text('${controller.user.value.email ?? ''}'),
                                    ],
                                  ),

                                  // elevated button for edit profile
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blueAccent,
                                      minimumSize: Size(double.infinity, 50),
                                    ),
                                    onPressed: () {
                                      isEditing.value = true;
                                      controller.nameController.value.text =
                                          controller.user.value.name;
                                      controller.firstnameController.value.text =
                                          controller.user.value.firstname;
                                      controller.emailController.value.text =
                                          controller.user.value.email;

                                    },
                                    child: const Text('Modifier'),
                                  ),
                                ],
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
        );
      },
    );
  }
}
