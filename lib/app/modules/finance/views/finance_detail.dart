import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/widgets/index.dart';
import 'package:shopkeeper/widgets/popup_drop_down.dart';

import '../export.dart';

class FinanceDetail extends GetView<FinanceController> {
  const FinanceDetail({
    Key? key,
    required this.walletId,
  }) : super(key: key);

  final int walletId;

  Widget buildListTile(FundsEntity item) {
    var typeText = ['收入', '支出', '欠款'];
    var date = DateUtil.formatDateMs(item.createAt!, format: "HH:mm:ss");
    var walletName = controller.detailState.getWalletNameById(item.walletId!);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(typeText[item.type!], style: TextStyle(fontSize: 16)),
                item.type == 0
                    ? Text(
                        '+ ${item.amount}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        '- ${item.amount}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ]),
              SizedBox(height: 8),
              DefaultTextStyle(
                style: TextStyle(fontSize: 12, color: Colors.grey),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date),
                    Text(walletName),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
        Divider(height: 0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: '查看详情',
        leading: CloseButton(),
        actions: [
          IconButton(
            icon: Icon(Icons.manage_search),
            onPressed: () => EasyPopup.show(
              context,
              PopupDropdown(child: PopupFliterView()),
              offsetLT: Offset(0, MediaQuery.of(context).padding.top + 57),
            ),
          ),
        ],
      ),
      body: GetX<FinanceController>(
        init: FinanceController(),
        initState: (_) {
          controller.detailState.filterDate.value = [];
          controller.detailState.filterWalletId.value = walletId;
          controller.walletState.initData();
          controller.detailState.initData();
        },
        builder: (_) {
          return CustomScrollView(
            slivers: [
              ...controller.detailState.detailList.map((element) {
                return SliverStickyHeader(
                  header: Container(
                    height: 30,
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(element['date']),
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => buildListTile(element['list'][index]),
                      childCount: element['list'].length,
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

// 筛选过滤
class PopupFliterView extends GetView<FinanceController> {
  PopupFliterView({Key? key}) : super(key: key);

  buildPickerButton(int index) {
    var filterDate = controller.detailState.filterDate;
    String dateStr = '-';

    for (var i = 0; i < filterDate.length; i++) {
      if (i == index) {
        dateStr =
            DateUtil.formatDateMs(filterDate[index], format: "yyyy/MM/dd");
        break;
      }
    }
    return OutlinedButton(
      onPressed: () => controller.detailState.datePicker(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(dateStr),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: GetX<FinanceController>(
        init: FinanceController(),
        initState: (_) {
          // controller.detailState.initData();
        },
        builder: (_) {
          return Container(
            height: 220,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('时间范围'),
                      buildPickerButton(0),
                      Text('至'),
                      buildPickerButton(1),
                    ],
                  ),
                ),
                ClickTileItem(
                  title: '查看类型',
                  customer: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: DropdownButton(
                      isDense: true,
                      underline: SizedBox(),
                      value: controller.detailState.filterType.value,
                      items: [
                        ...controller.detailState.filterTypeText
                            .asMap()
                            .keys
                            .map((index) {
                          var value =
                              controller.detailState.filterTypeText[index];
                          return DropdownMenuItem(
                            value: index,
                            child: Text(value),
                          );
                        }),
                      ],
                      onChanged: (value) {
                        controller.detailState.filterType.value = value as int;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        EasyPopup.pop(context);
                        controller.detailState.initData();
                      },
                      child: Text('确定'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
