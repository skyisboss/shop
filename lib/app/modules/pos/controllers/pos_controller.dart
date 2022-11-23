import 'package:get/get.dart';

import '../export.dart';

class PosController extends GetxController {
  final cartState = CartState();
  final orderState = OrderState();
  final posState = PosState();

  /// 顶部显示搜索框
  final _isShowSearch = false.obs;
  set isShowSearch(val) => _isShowSearch.value = val;
  bool get isShowSearch => _isShowSearch.value;

  /// 布局方式
  final _gridLayout = true.obs;
  set gridLayout(val) => _gridLayout.value = val;
  bool get gridLayout => _gridLayout.value;

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
}
