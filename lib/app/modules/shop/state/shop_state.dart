// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopState {
  /// 店铺头像
  final _shopAvatar = ''.obs;
  String get shopAvatar => _shopAvatar.value;
  set shopAvatar(val) => _shopAvatar.value = val;

  /// 店铺名称
  final _shopName = ''.obs;
  String get shopName => _shopName.value;
  set shopName(val) => _shopName.value = val;

  /// 线上销售
  final _onlineSales = ''.obs;
  bool get onlineSales => _onlineSales.value == '1' ? true : false;
  set onlineSales(val) => _onlineSales.value = val;

  /// 线上地址
  final _onlineUrl = ''.obs;
  String get onlineUrl => _onlineUrl.value;
  set onlineUrl(val) => _onlineUrl.value = val;

  /// 最近数据同步时间
  final _syncLastTime = ''.obs;
  String get syncLastTime => _syncLastTime.value;
  set syncLastTime(val) => _syncLastTime.value = val;

  /// 联系电话
  final _contactNumber = ''.obs;
  String get contactNumber => _contactNumber.value;
  set contactNumber(val) => _contactNumber.value = val;

  /// 联系地址
  final _contactAddress = ''.obs;
  String get contactAddress => _contactAddress.value;
  set contactAddress(val) => _contactAddress.value = val;

  /// 运费价格
  final _shippingFee = ''.obs;
  String get shippingFee => _shippingFee.value;
  set shippingFee(val) => _shippingFee.value = val;

  /// 支付方式
  final _paymentMethods = [
    {
      'title': 'cash_pay',
      'label': '现金',
      'active': false.obs,
    },
    {
      'title': 'wechat_pay',
      'label': '微信支付',
      'active': false.obs,
    },
    {
      'title': 'alipay_pay',
      'label': '支付宝',
      'active': false.obs,
    },
    {
      'title': 'credit_pay',
      'label': '信用卡',
      'active': false.obs,
    },
  ];
  List<Map<String, Object>> get paymentMethods => _paymentMethods;
  get paymentMethodContent => () {
        var _list = [];
        paymentMethods.map((element) {
          if ((element['active'] as RxBool).value) {
            _list.add(element['label'] as String);
          }
        }).toList();
        return _list.join('，');
      };

  /// 社交媒体
  final _socialMedias = [
    {
      'title': 'facebook',
      'label': 'facebook',
      'logo': 'assets/images/logo/facebook-circle-fill.png',
      'color': Colors.blue.shade600,
      'active': false.obs,
      'link': ''.obs,
    },
    {
      'title': 'wechat',
      'label': 'wechat',
      'logo': 'assets/images/logo/wechat-fill.png',
      'color': Colors.green,
      'active': false.obs,
      'link': ''.obs,
    },
    {
      'title': 'weibo',
      'label': 'weibo',
      'logo': 'assets/images/logo/weibo-fill.png',
      'color': Colors.red.shade600,
      'active': false.obs,
      'link': ''.obs,
    },
    {
      'title': 'instagram',
      'label': 'instagram',
      'logo': 'assets/images/logo/instagram-fill.png',
      'color': Colors.purple.shade300,
      'active': false.obs,
      'link': ''.obs,
    },
    {
      'title': 'twitter',
      'label': 'twitter',
      'logo': 'assets/images/logo/twitter-fill.png',
      'color': Colors.blue.shade400,
      'active': false.obs,
      'link': ''.obs,
    },
    {
      'title': 'youtube',
      'label': 'youtube',
      'logo': 'assets/images/logo/youtube-fill.png',
      'color': Colors.red,
      'active': false.obs,
      'link': ''.obs,
    },
    {
      'title': 'line',
      'label': 'line',
      'logo': 'assets/images/logo/line-fill.png',
      'color': Colors.green,
      'active': false.obs,
      'link': ''.obs,
    },
    {
      'title': 'whatsapp',
      'label': 'whatsapp',
      'logo': 'assets/images/logo/whatsapp-fill.png',
      'color': Colors.green.shade300,
      'active': false.obs,
      'link': ''.obs,
    },
  ];
  List<Map<String, Object>> get socialMedias => _socialMedias;

  /// 本地货币
  final _localCurrency = ''.obs;
  set localCurrency(val) => _localCurrency.value = val;
  get localCurrency => _localCurrency.value;
  get localCurrencyText => () {
        var res = '';
        _localCurrencyList.map((e) {
          if (e['key'] == localCurrency) {
            res = (e['label'] as String) + '/' + (e['symbols'] as String);
          }
        }).toList();
        return res;
      };

  final _localCurrencyList = [
    {
      'key': 'CNY',
      'symbols': '¥',
      'label': '人民币',
    },
    {
      'key': 'USD',
      'symbols': '\$',
      'label': '美元',
    },
    {
      'key': 'EUR',
      'symbols': '€',
      'label': '欧元',
    },
    {
      'key': 'PHP',
      'symbols': '₱',
      'label': '菲律宾披索',
    },
    {
      'key': 'TWD',
      'symbols': 'NT\$',
      'label': '新台币',
    },
    {
      'key': 'HKD',
      'symbols': '\$',
      'label': '港币',
    },
    {
      'key': 'MYR',
      'symbols': 'RM',
      'label': '马来西亚令吉',
    },
    {
      'key': 'JPY',
      'symbols': '¥',
      'label': '日圆',
    },
    {
      'key': 'GBP',
      'symbols': '£',
      'label': '英镑',
    },
    {
      'key': 'SGD',
      'symbols': '\$',
      'label': '新加坡元',
    },
    {
      'key': 'THB',
      'symbols': '฿',
      'label': '泰铢',
    },
    {
      'key': 'VND',
      'symbols': '₫',
      'label': '越南盾',
    },
    {
      'key': 'IDR',
      'symbols': 'Rp',
      'label': '印尼盾',
    },
    {
      'key': 'other',
      'symbols': '¤',
      'label': '其他币种',
    },
  ];
  List<Map<String, Object>> get localCurrencyList => _localCurrencyList;
}
