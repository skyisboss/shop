import 'package:get/get.dart';

import 'common.dart';

/// 全局静态数据
class Global {
  /// 初始化基础数据
  static Future init() async {
    Get.put<CommonStore>(CommonStore());
  }
}
