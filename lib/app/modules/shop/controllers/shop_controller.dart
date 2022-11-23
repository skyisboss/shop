import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopkeeper/app/modules/shop/dao/shop_dao.dart';
import 'package:shopkeeper/app/modules/shop/models/shop_model.dart';
import 'package:shopkeeper/app/modules/shop/state/shop_state.dart';
import 'package:shopkeeper/common/db/index.dart';

class ShopController extends GetxController {
  final state = ShopState();

  // 图片选择
  imagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result == null) return;
    File file = File(result.files.single.path.toString());

    /// 获取应用程序目录文件 创建目标路径
    final dir = await getApplicationSupportDirectory();
    File target = File('${dir.path}/${result.files.single.name}');

    try {
      // 复制文件
      await file.copy(target.path);
      handleSetAssign('shopAvatar', target.path);
    } catch (e) {
      print("复制失败");
    }
  }

  /// 赋值操作
  handleSetAssign(String key, String value, {bool updateDb = true}) async {
    switch (key) {
      case 'shopName':
        state.shopName = value;
        break;
      case 'shopAvatar':
        state.shopAvatar = value;
        break;
      case 'syncLastTime':
        state.syncLastTime = value;
        break;
      case 'contactNumber':
        state.contactNumber = value;
        break;
      case 'contactAddress':
        state.contactAddress = value;
        break;
      case 'shippingFee':
        state.shippingFee = value;
        break;
      case 'onlineSales':
        state.onlineSales = value;
        break;
      case 'onlineUrl':
        state.onlineUrl = value;
        break;
      case 'paymentMethods':
        // value = {"cash_pay":"0","wechat_pay":"0","alipay_pay":"0","credit_pay":"0"}
        var _json = json.decode(value);
        state.paymentMethods.map((element) {
          var _value = _json[element['title']];
          (element['active'] as RxBool).value = _value == '1' ? true : false;
        });
        updateDb = false;
        break;
      // 支付方式
      case 'cash_pay':
      case 'wechat_pay':
      case 'alipay_pay':
      case 'credit_pay':
        // int i = state.paymentMethods.indexWhere((e) => e['title'] == key);
        // var element = state.paymentMethods[i]['active'] as RxBool;
        // element.value = value == '1' ? true : false;
        break;
      case 'localCurrency':
        state.localCurrency = value;
        break;
      // 社交媒体
      case 'facebook':
      case 'wechat':
      case 'weibo':
      case 'instagram':
      case 'twitter':
      case 'youtube':
      case 'line':
      case 'whatsapp':
        // {"link": "", "active": "0"}
        var _json = json.decode(value);
        int _index = state.socialMedias.indexWhere((e) => e['title'] == key);
        var element = state.socialMedias[_index];
        (element['link'] as RxString).value = _json['link'];
        (element['active'] as RxBool).value =
            _json['active'] == '1' ? true : false;
        break;
      default:
        return;
    }

    // 是否更新到数据库
    if (updateDb) {
      ShopDao dao = ShopDao();
      ShopModel data = ShopModel(key: key, value: value);
      await dao.update(key, data);
    }
  }

  // 初始化数据
  initData() async {
    //获取数据
    ShopDao dao = ShopDao();
    // 如果表不存在则插入原始数据, 否则读取数据
    if (false == await dao.isTableExits()) {
      List<ShopModel> _baseDatas = [
        ShopModel(key: 'shopName', value: '店管家 - Shopkeeper'),
        ShopModel(key: 'shopAvatar', value: ''),
        ShopModel(key: 'onlineSales', value: '0'),
        ShopModel(key: 'onlineUrl', value: 'https://ishopkeeper.com/s/pkmp4'),
        ShopModel(key: 'localCurrency', value: 'CNY'),
        ShopModel(key: 'facebook', value: '{"link": "", "active": "0"}'),
        ShopModel(key: 'wechat', value: '{"link": "", "active": "0"}'),
        ShopModel(key: 'weibo', value: '{"link": "", "active": "0"}'),
        ShopModel(key: 'instagram', value: '{"link": "", "active": "0"}'),
        ShopModel(key: 'twitter', value: '{"link": "", "active": "0"}'),
        ShopModel(key: 'youtube', value: '{"link": "", "active": "0"}'),
        ShopModel(key: 'line', value: '{"link": "", "active": "0"}'),
        ShopModel(key: 'whatsapp', value: '{"link": "", "active": "0"}'),
        ShopModel(key: 'syncLastTime', value: ''),
        ShopModel(key: 'contactNumber', value: ''),
        ShopModel(key: 'contactAddress', value: ''),
        ShopModel(key: 'shippingFee', value: ''),
        ShopModel(key: 'wechat_pay', value: '0'),
        ShopModel(key: 'alipay_pay', value: '0'),
        ShopModel(key: 'credit_pay', value: '0'),
      ];
      for (var item in _baseDatas) {
        await dao.insert(item);
        print('初始化数据 {$item["key"]}');
      }
    }
    var result = await dao.findAll();
    for (var item in result) {
      // handleUpdate(item.key, item.value, save2db: false);
      handleSetAssign(item.key, item.value, updateDb: false);
    }
  }

  @override
  void onInit() async {
    await initData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() async {
    DBManger.close();
  }
}
