import 'package:get/get.dart';

import '../controllers/check_cart_controller.dart';

class CheckCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckCartController>(
      () => CheckCartController(),
    );
  }
}
