import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/mine/state/mine_state.dart';

class MineController extends GetxController {
  final state = MineState();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
