import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/profil_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  final isEditing = false.obs;

  ProfileController get controller => Get.put(ProfileController());

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
                                // - password
                                TextFormField(
                                  obscureText: true,
                                  controller: controller.passwordController
                                      .value,
                                  decoration: const InputDecoration(
                                    hintText: 'Mot de passe',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                // - confirm password

                                // submit button
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blueAccent,
                                    minimumSize: Size(double.infinity, 50),
                                  ),
                                  onPressed: () {
                                    controller.updateProfile();
                                  },
                                  child: const Text('Enregistrer'),
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
