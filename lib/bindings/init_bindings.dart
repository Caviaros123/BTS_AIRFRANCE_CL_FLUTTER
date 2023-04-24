import 'package:airfrance/controllers/profil_controller.dart';
import 'package:get/get.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    // init car controller
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}