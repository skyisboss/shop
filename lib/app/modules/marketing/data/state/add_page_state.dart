import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shopkeeper/app/modules/marketing/controllers/marketing_controller.dart';
import 'package:shopkeeper/app/modules/marketing/data/export.dart';
import 'package:shopkeeper/widgets/index.dart';

class AddPageState {
  final pageTypeList = ['折扣', '优惠券'];
  final actionTypeList = ['新增', '编辑'];
  final discountTextList = ['面值', '百分比'];
  final conditionTextList = ['>=', '<='];

  /// 新增或编辑
  final _addData = DiscountEntity(
    title: '',
    type: 0,
    discountAmount: 0,
    amountType: 0,
    expiredDate: 0,
    maxAmount: 0,
    minAmount: 0,
    totalNum: 0,
  ).obs;
  Rx<DiscountEntity> get addDataUpdate => _addData;
  DiscountEntity get addData => _addData.value;

  String get title => addData.title;
  set title(val) => addData.title = val;

  double get discountAmount => addData.discountAmount;
  set discountAmount(val) =>
      val.isEmpty ? 0 : addData.discountAmount = double.parse(val);

  int get amountType => addData.amountType;
  String get amountTypeText => discountTextList[addData.amountType];
  set amountType(val) => addData.amountType = int.parse(val);

  int get expiredDate => addData.expiredDate;
  String get expiredDateFormat => addData.expiredDate == 0
      ? '请选择'
      : DateUtil.formatDateMs(addData.expiredDate, format: "yyyy-MM-d");
  set expiredDate(val) => addData.expiredDate = int.parse(val);

  int get totalNum => addData.totalNum;
  set totalNum(val) => val.isEmpty ? 0 : addData.totalNum = int.parse(val);

  double get maxAmount => addData.maxAmount;
  set maxAmount(val) => val.isEmpty ? 0 : addData.maxAmount = double.parse(val);

  double get minAmount => addData.minAmount;
  set minAmount(val) => val.isEmpty ? 0 : addData.minAmount = double.parse(val);

  /// 输入框控制器
  final titleController = TextEditingController();
  final titleFocusNode = FocusNode();

  final discountAmountController = TextEditingController();
  final discountAmountFocusNode = FocusNode();

  final minAmountController = TextEditingController();
  final minAmountFocusNode = FocusNode();

  final maxAmountController = TextEditingController();
  final maxAmountFocusNode = FocusNode();

  final totalNumController = TextEditingController();
  final totalNumFocusNode = FocusNode();

  /// 保存操作
  onDone(int? id) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (title.isEmpty) {
      titleFocusNode.requestFocus();
      EasyLoading.showError('请输入${pageTypeList[addData.type]}名称');
      return;
    }
    if (discountAmount == 0) {
      discountAmountFocusNode.requestFocus();
      EasyLoading.showError('请输入${pageTypeList[addData.type]}金额');
      return;
    }
    if (expiredDate == 0) {
      EasyLoading.showError('请选择过期时间');
      datePicker();
      return;
    }
    // minAmount=0 或者 maxAmount=0 不限制使用条件
    if (minAmount != 0 || maxAmount != 0) {
      if (maxAmount < minAmount) {
        maxAmountFocusNode.requestFocus();
        EasyLoading.showError('最大金额不符合');
        return;
      }
    }
    // totalNum=0 无限数量

    DiscountDao dao = DiscountDao();
    int _result;
    String _title;
    if (id == null) {
      _result = await dao.insert(addData);
      _title = '添加成功';
    } else {
      _result = await dao.update(id, addData);
      _title = '编辑成功';
    }

    if (_result > 0) {
      EasyLoading.showSuccess(_title);
      Get.back();
      // 更新数据
      var listState = Get.find<MarketingController>().listState;
      listState.onRefresh(0);
      listState.onRefresh(1);
      return;
    }
    EasyLoading.showError('操作失败');
  }

  /// 删除操作
  onDelete(int id) {
    onConfirm() async {
      DiscountDao dao = DiscountDao();
      var result = await dao.remove(id);
      if (result > 0) {
        EasyLoading.showSuccess('删除成功');
        Get.back();
        // 更新数据
        var listState = Get.find<MarketingController>().listState;
        listState.onRefresh(0);
        listState.onRefresh(1);
        return;
      }
      EasyLoading.showError('删除失败');
    }

    cupertinoDialog(
      Get.context!,
      title: Text('确定删除吗'),
      onConfirm: onConfirm,
    );
  }

  /// 时间选择
  datePicker() {
    var _dateNow = DateTime.now();
    // 将时间戳转为日期
    PDuration selectDate;
    if (expiredDate > 0) {
      var _strtime = DateTime.fromMillisecondsSinceEpoch(expiredDate);
      selectDate = PDuration(
        year: _strtime.year,
        month: _strtime.month,
        day: _strtime.day,
      );
    } else {
      selectDate = PDuration();
    }

    Pickers.showDatePicker(
      Get.context!,
      // 模式，详见下方
      mode: DateMode.YMD,
      // 后缀 默认Suffix.normal()，为空的话Suffix()
      suffix: Suffix(years: ' 年', month: ' 月', days: ' 日'),
      // 样式  详见下方样式
      pickerStyle: DefaultPickerStyle(haveRadius: true),

      // 默认选中 可以自定义设置年月日时分秒
      selectDate: selectDate,

      minDate: PDuration(
        year: _dateNow.year,
        month: _dateNow.month,
        day: _dateNow.day + 1,
      ),
      maxDate: PDuration(year: _dateNow.year + 1),
      onConfirm: (p) {
        String dateStr = '${p.year}-${p.month}-${p.day}';
        DateFormat format = DateFormat("yyyy-MM-dd");
        addDataUpdate.update((val) {
          val!.expiredDate = format.parse(dateStr).millisecondsSinceEpoch;
        });
      },
      // onChanged: (p) => print(p),
    );
  }

  // 初始化数据
  initData(int? id, int type) async {
    _addData.value = DiscountEntity(
      title: '',
      type: type,
      discountAmount: 0,
      amountType: 1,
      expiredDate: 0,
      maxAmount: 0,
      minAmount: 0,
      totalNum: 0,
    );
    if (id != null) {
      DiscountDao dao = DiscountDao();
      var result = await dao.findOne('id = ?', [id]);
      if (result.isNotEmpty) {
        _addData.value = result[0];
      }
    }
    titleController.text = title;
    discountAmountController.text = discountAmount.toString();
    minAmountController.text = minAmount.toString();
    maxAmountController.text = maxAmount.toString();
    totalNumController.text = totalNum.toString();
  }
}
