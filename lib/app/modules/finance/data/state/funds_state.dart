import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../export.dart';

class FundsState {
  // 新增记录
  final _addData = FundsEntity().obs;
  Rx<FundsEntity> get addData => _addData;
  set amount(val) => addData.value.amount = double.parse(val);
  double get amount => addData.value.amount ?? 0;

  int get type => addData.value.type ?? -1;
  set type(val) => addData.value.type = val;

  int get walletId => addData.value.walletId ?? 0;

  set walletId(val) => addData.value.walletId = val;

  String get remark => addData.value.remark ?? '';
  set remark(val) => addData.value.remark = val;

  String get file => addData.value.file ?? '';
  set file(val) => addData.value.file = val;

  ///统计概览
  final totalList = [
    {'title': '收入', 'total': '0', 'amount': '0.00'},
    {'title': '支出', 'total': '0', 'amount': '0.00'},
    {'title': '欠款', 'total': '0', 'amount': '0.00'},
  ].obs;

  initTotalInfo() async {
    FundsDao dao = FundsDao();
    for (var i = 0; i < totalList.length; i++) {
      var res = await dao.finalTotal(type: i);
      if (res.isNotEmpty) {
        totalList[i]['total'] = res[0]['total'].toString();
        totalList[i]['amount'] = (res[0]['amount'] ?? 0.0).toString();
      }
    }
    totalList.refresh();
  }

  // 提交数据
  onDone() async {
    if (addData.value.amount == null || addData.value.amount == 0) {
      EasyLoading.showError('输入记录金额');
      return;
    }
    addData.value.type ??= 0;
    addData.value.walletId ??= 1;
    addData.value.createAt ??= DateTime.now().millisecondsSinceEpoch;

    FundsDao dao = FundsDao();
    var res = await dao.insert(addData.value);
    if (res > 0) {
      EasyLoading.showSuccess('添加成功');
      Get.back();
      return;
    }
    EasyLoading.showError('操作失败');
  }

  // 钱包列表
  RxList<WalletEntity> getWalletList() {
    var controller = Get.find<FinanceController>();
    return controller.walletState.walletList;
  }

  // 获取钱包id对应的名称
  String getWalletTitle() {
    var res = getWalletList().where((e) => e.id == walletId);
    return res.isNotEmpty ? res.first.name! : '请选择';
  }

  initData() async {
    _addData.value = FundsEntity();

    var controller = Get.find<FinanceController>();
    await controller.walletState.initData();
  }
}
