import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'common/i18n/i18n.dart';
import 'common/style/theme.dart';
import 'common/values/common.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  debugPrint('starting services ...');
  // 初始化基础数据 静态数据
  await Get.putAsync(() => CommonStore().init());

  // 启动app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'app_name'.tr,
      debugShowCheckedModeBanner: false,
      theme: MyTheme.light,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: I18ns.locale,
      translations: I18ns(),
      fallbackLocale: const Locale('en', 'US'),
      builder: EasyLoading.init(),
    );
  }
}
