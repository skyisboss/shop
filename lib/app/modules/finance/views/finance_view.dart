import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:shopkeeper/common/style/colors.dart';
import 'package:shopkeeper/widgets/index.dart';

import '../controllers/finance_controller.dart';
import 'add_finance.dart';
import 'finance_detail.dart';
import 'wallet_view.dart';

class FinanceView extends GetView<FinanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text('财务'),
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              EasyPopup.show(
                context,
                DropPopupMenu(actions: [
                  MenuItem(
                    title: '资金记录',
                    onTap: () => Get.off(() => AddFinance()),
                  ),
                  MenuItem(
                    title: '钱包账户',
                    onTap: () => Get.off(() => WalletView()),
                  ),
                ]),
                offsetLT: Offset(0, MediaQuery.of(context).padding.top + 50),
              );
            },
          ),
        ],
      ),
      body: GetX<FinanceController>(
        init: FinanceController(),
        initState: (_) {
          // 初始化钱包数据
          controller.walletState.initData();
          controller.walletState.initWalletFundsList();

          controller.fundsState.initTotalInfo();
        },
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: [
                buildTotalCard(),
                buildWalletList(),
              ],
            ),
          );
        },
      ),
    );
  }

  // 信息统计
  Widget buildTotalCard() {
    var totalList = controller.fundsState.totalList;
    return Container(
      height: 170,
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 32, right: 32, top: 20),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/finance/bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          DefaultTextStyle(
            style: TextStyle(fontSize: 14, color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('收入 ${totalList[0]["total"]} 笔'),
                    SizedBox(height: 6),
                    Text('${totalList[0]["amount"]}'),
                  ],
                ),
                Column(
                  children: [
                    Text('支出 ${totalList[1]["total"]} 笔'),
                    SizedBox(height: 6),
                    Text('${totalList[1]["amount"]}'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          DefaultTextStyle(
            style: TextStyle(fontSize: 14, color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('欠款 ${totalList[2]["total"]} 笔'),
                    SizedBox(height: 6),
                    Text('${totalList[2]["amount"]}'),
                  ],
                ),
                InkWell(
                  onTap: () => Get.to(() => WalletView()),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.blue.shade50,
                    child: Icon(Icons.more_horiz, size: 30),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWalletList() {
    return ListTileGroup(
      showBorder: false,
      children: [
        ...controller.walletState.walletFundsList.map((x) {
          return ListTile(
            onTap: () => Get.to(() => FinanceDetail(walletId: x.id!)),
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                controller.walletState.handleLogo(x.name!),
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(x.name!),
            subtitle: Text(x.timesCount!.toString() + ' 笔'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text((x.amountCount ?? 0).toString()),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
          );
        }),
      ],
    );
  }
}
