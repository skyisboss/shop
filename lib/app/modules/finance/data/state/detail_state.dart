import 'package:common_utils/common_utils.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../export.dart';

/// 查看详资金记录情页
class DetailState {
  final _detailList = [].obs;
  RxList get detailList => _detailList;

  // 筛选条件
  final filterWalletId = 0.obs;
  final filterDate = <int>[].obs; // 开始和结束时间， 默认为空,即查询所有
  final filterType = 3.obs; // 查询的记录类型，默认查询收入，支出和欠款
  final filterTypeText = ['支出', '收入', '欠款', '全部'];

  String getWalletNameById(int id) {
    var walletList = Get.find<FinanceController>().walletState.walletList;
    var walletName = '';
    for (var item in walletList) {
      if (item.id == id) {
        walletName = item.name!;
        break;
      }
    }
    return walletName;
  }

  // 初始化详情数据
  void initData() async {
    // 第二个时间必须比第一个时间大
    if (filterDate.isNotEmpty && filterDate[0] > filterDate[1]) {
      filterDate.value = [];
    }

    FundsDao dao = FundsDao();
    var res = await dao.findDetail(
      wid: filterWalletId.value,
      type: filterType.value != 3 ? filterType.value : null,
      time: filterDate.isNotEmpty ? filterDate : null,
    );

    // 数据转换成 SliverStickyHeader 可接受的类型
    detailList.clear();
    detailList.addAll(groupBy(res));
  }

  List groupBy(List<FundsEntity> array) {
    var list = [];
    for (var item in array) {
      var date = DateUtil.formatDateMs(item.createAt!, format: "yyyy/M/d");
      var index = list.indexWhere((e) => e['date'] == date);

      if (index < 0) {
        list.add({
          'date': date,
          'list': <FundsEntity>[item],
        });
      } else {
        list[index]['list'].add(item);
      }
    }
    return list;
  }

  datePicker(int index) {
    DateTime _dateTime = DateTime.now();
    for (var i = 0; i < filterDate.length; i++) {
      if (i == index) {
        _dateTime = DateTime.fromMillisecondsSinceEpoch(filterDate[index]);
        break;
      }
    }
    var selectDate = PDuration(
      year: _dateTime.year,
      month: _dateTime.month,
      day: _dateTime.day,
    );
    var minDate = PDuration();
    if (filterDate.isNotEmpty && index == 1) {
      // 将第一个时间作为基础时间,第二个时间比第一个时间大
      _dateTime = DateTime.fromMillisecondsSinceEpoch(filterDate.first);
      minDate = PDuration(
        year: _dateTime.year,
        month: _dateTime.month,
        day: _dateTime.day,
      );
    }

    Pickers.showDatePicker(
      Get.context!,
      // 模式，详见下方
      mode: DateMode.YMD,
      // 后缀 默认Suffix.normal()，为空的话Suffix()
      suffix: Suffix(years: ' 年', month: ' 月', days: ' 日'),
      // 样式  详见下方样式
      pickerStyle: DefaultPickerStyle(haveRadius: true),

      // 默认选中年月日
      selectDate: selectDate,
      minDate: minDate,
      onConfirm: (e) {
        String dateStr = '${e.year}-${e.month}-${e.day}';
        DateFormat format = DateFormat("yyyy-MM-dd");
        int t = format.parse(dateStr).millisecondsSinceEpoch;

        bool hasExtis = false;
        for (var i = 0; i < filterDate.length; i++) {
          if (i == index) {
            filterDate[index] = t;
            hasExtis = true;
            break;
          }
        }
        if (!hasExtis) {
          filterDate.add(t);
        }
        filterDate.refresh();
      },
    );
  }
}
