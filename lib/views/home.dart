
import 'dart:convert';

import 'package:airfrance/views/auth/login.dart';
import 'package:airfrance/views/profil/profil_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/profil_controller.dart';
import 'aeroports/aeroports_view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final box = GetStorage();

  bool isEditing = false;

  // init tabview controller
  late final tabController;

  final tabs = <Tab>[
    Tab(icon: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(Icons.person, color: Colors.black38,),
        Text('Profil', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black38),)
      ],
    )),
    Tab(icon: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(Icons.connecting_airports_outlined, color: Colors.black38,),
        Text('Aéroports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black38),)
      ],
    )),
    Tab(icon: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.airplane_ticket, color: Colors.black38,),
        Text('Avions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black38),)
      ],
    )),
    Tab(icon: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(Icons.personal_injury_outlined, color: Colors.black38,),
        Text('Pilotes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black38),)
      ],
    )),
    Tab(icon: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(Icons.airplanemode_active, color: Colors.black38,),
        Text('Vol', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black38),)
      ],
    )),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          box.erase();
          Get.delete<ProfileController>();
          Get.offAll(() => LoginScreen());
        },
        child: const Icon(Icons.logout),
      ),
      body: Column(
        children: [
          // tabview
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TabBar(
              controller: tabController,
              tabs: tabs,
            ),
          ),
          // tabview content
          Expanded(
            child: _buildTabView(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabView() {
    return TabBarView(
      controller: tabController,
      children: [
        ProfileView(),
        const AeroportsView(),
        ProfileView(),
        ProfileView(),
        ProfileView(),
      ],
    );
  }
}
