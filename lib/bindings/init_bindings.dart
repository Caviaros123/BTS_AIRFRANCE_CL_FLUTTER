import 'package:airfrance/controllers/profil_controller.dart';
import 'package:get/get.dart';

import '../controllers/airport_controller.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    // init car controller
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<AirportController>(
          () => AirportController(),
    );
  }
}