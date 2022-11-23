import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:get/get.dart';

import '../../export.dart';

class AddState {
  // 添加信息
  final _addData = CustomerEntity().obs;
  Rx<CustomerEntity> get addData => _addData;

  String get username => _addData.value.username ?? '';
  int get groupId => _addData.value.groupId ?? 1;
  String get avatar => _addData.value.avatar ?? '';
  int get gender => _addData.value.gender ?? 0;
  String get telephone => _addData.value.telephone ?? '';
  String get address => _addData.value.address ?? '';
  String get birthday => _addData.value.birthday ?? '';
  String get remark => _addData.value.remark ?? '';

  String getGroupName() {
    var index = groupList.indexWhere((item) => item.id == groupId);
    if (index < 0) {
      return '请选择';
    }
    return groupList[index].groupName;
  }

  /// 用户组列表
  final _groupList = <GroupEntity>[].obs;
  RxList<GroupEntity> get groupList => _groupList;
  get activeGroup => _addData.value.groupId!;

  // 提交数据
  onDone() async {
    if (username.isEmpty) {
      EasyLoading.showError('请输入用户名');
      return;
    }

    CustomerDao dao = CustomerDao();
    var result = await dao.insert(addData.value);
    if (result > 0) {
      EasyLoading.showSuccess('操作成功');
      Get.back();
      return;
    }
    EasyLoading.showError('操作失败');
  }

  findCustomer(int id) async {
    CustomerDao dao = CustomerDao();
    var result = await dao.findOne('id = ?', [id]);
    if (result.isNotEmpty) {
      _addData.value = result[0];
    }
  }

  // 初始化用户组
  void initGroupData() async {
    GroupDao dao = GroupDao();
    var result = await dao.findAll();
    if (result.isNotEmpty) {
      _groupList.clear();
      _groupList.addAll(result);
    }
  }

  // 日期选择
  datePicker() {
    var _dateNow = DateTime.now();
    Pickers.showDatePicker(
      Get.context!,
      // 模式，详见下方
      mode: DateMode.YMD,
      // 后缀 默认Suffix.normal()，为空的话Suffix()
      suffix: Suffix(years: ' 年', month: ' 月', days: ' 日'),
      // 样式  详见下方样式
      pickerStyle: DefaultPickerStyle(haveRadius: true),

      // 默认选中 可以自定义设置年月日时分秒
      // selectDate: selectDate,

      // minDate: PDuration(
      //   year: _dateNow.year,
      //   month: _dateNow.month,
      //   day: _dateNow.day + 1,
      // ),
      maxDate: PDuration(year: _dateNow.year + 1),
      onConfirm: (p) {
        String dateStr = '${p.year}-${p.month}-${p.day}';
        // DateFormat format = DateFormat("yyyy-MM-dd");
        // addDataUpdate.update((val) {
        //   val!.expiredDate = format.parse(dateStr).millisecondsSinceEpoch;
        // });
        // print(format.parse(dateStr).toString());
        _addData.update((val) => val?.birthday = dateStr);
      },
      // onChanged: (p) => print(p),
    );
  }

  // 头像选择
  imagePicker(e) {
    _addData.update((val) => val?.avatar = e);
  }
}
