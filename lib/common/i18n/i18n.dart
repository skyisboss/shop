import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'zh_cn.dart';
import 'en_us.dart';
// import 'zh_hk.dart';

class I18ns extends Translations {
  static Locale? get locale => const Locale('zh', 'CN');
  final fallbackLocale = const Locale('en', 'US');
  @override
  get keys => {
        'zh_CN': zh_CN,
        'en_US': en_US,
        // 'zh_HK': zh_HK,
      };
}
