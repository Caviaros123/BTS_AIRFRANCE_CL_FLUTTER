
import 'dart:io';

import 'package:airfrance/controllers/profil_controller.dart';
import 'package:airfrance/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(TitleBarStyle.hidden); //Hiding the titlebar
      await windowManager.setTitle("I don't have a titlebar!"); //We don't have a titlebar, this title appears in Task Manager for example.
      await windowManager.show(); //Finally show app window.
      await windowManager.setSize(const Size(1000, 700)); //Finally show app window.
    });
  }
  await GetStorage.init();

  await Get.putAsync(() => ProfileController().init());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});



   final box = GetStorage();

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return GetMaterialApp(
      title: 'Air France PPE',
      smartManagement: SmartManagement.onlyBuilder,
      // navigatorObservers: [FlutterSmartDialog.observer],
      // builder: FlutterSmartDialog.init(),
      locale: Get.deviceLocale,
      // translations: LocaleString(),
      fallbackLocale: Get.fallbackLocale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.appPages,
      // I add my list of pages here
      initialRoute: AppPages
          .INITIAL,
    );
  }
}