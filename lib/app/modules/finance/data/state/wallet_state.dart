import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/widgets/index.dart';

import '../../export.dart';

class WalletState {
  /// 钱包列表
  final _walletList = <WalletEntity>[].obs;
  RxList<WalletEntity> get walletList => _walletList;

  /// 钱包对应交易金额、次数统计
  final _walletFundsList = <WalletFundsEntity>[].obs;
  RxList<WalletFundsEntity> get walletFundsList => _walletFundsList;

  // 查询钱包对应交易金额、次数统计
  initWalletFundsList() async {
    WalletDao dao = WalletDao();
    var res = await dao.findFunds();
    if (res.isNotEmpty) {
      _walletFundsList.clear();
      _walletFundsList.addAll(res);
    }
  }

  handleAdd(WalletEntity? element) {
    final textEditingController =
        TextEditingController(text: element?.name ?? '');
    final inputContent = Material(
      color: Colors.transparent,
      child: Container(
        height: 55,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          controller: textEditingController,
          maxLength: 30,
          decoration: InputDecoration(
            hintText: '输入账户名称',
            hintStyle: TextStyle(fontSize: 13),
            filled: true,
            fillColor: Colors.grey.shade300,
            contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
      ),
    );
    onConfirm() async {
      int res;
      WalletDao dao = WalletDao();
      var text = textEditingController.text.trim();
      if (text == element?.name || text.isEmpty) {
        return;
      }
      if (element == null) {
        //新增
        res = await dao.insert(WalletEntity(name: text));
      } else {
        res = await dao.update(
            element.id!, WalletEntity(id: element.id!, name: text));
      }

      if (res > 0) {
        initData();
        EasyLoading.showSuccess('操作成功');
        return;
      }
      EasyLoading.showError('操作失败');
    }

    cupertinoDialog(
      Get.context as BuildContext,
      title: Text(element == null ? '添加账户' : '编辑账户'),
      content: inputContent,
      onConfirm: onConfirm,
    );
  }

  handleDelete(int id) {
    onConfirm() async {
      WalletDao dao = WalletDao();
      var res = await dao.remove(id);
      if (res > 0) {
        EasyLoading.showSuccess('操作成功');
        initData();
        return;
      }
      EasyLoading.showError('操作失败');
    }

    cupertinoDialog(
      Get.context as BuildContext,
      title: Text('确定删除吗'),
      onConfirm: onConfirm,
    );
  }

  Future initData() async {
    WalletDao dao = WalletDao();
    var result = await dao.findAll();
    _walletList.clear();
    _walletList.addAll(result);
    return true;
  }

  String handleLogo(String name) {
    String logo = '';
    if (name.isNotEmpty) {
      logo = name.substring(0, 1);
    }
    return logo.toUpperCase();
  }
}
