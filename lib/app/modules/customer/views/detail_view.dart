import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/common/style/colors.dart';
import 'package:shopkeeper/widgets/index.dart';

import '../export.dart';
import 'add_view.dart';

class DetailView extends GetView<CustomerController> {
  const DetailView({Key? key, required this.id}) : super(key: key);
  final int id;

  /// 会员卡片
  Widget buildCustomerCard() {
    // /用户卡片
    final _userCard = Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0x805793FA),
            offset: Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('USER', style: TextStyle(fontSize: 18, color: Colors.white)),
              Text('VIP', style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: 8),
          Text('phone', style: TextStyle(color: Colors.white)),
          SizedBox(height: 26),
          Text('No.0001', style: TextStyle(color: Colors.white)),
        ],
      ),
    );

    /// 用户概览
    final _userOverview = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(children: [
          Text('消费金额', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('0.0'),
        ]),
        Column(children: [
          Text('消费次数', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('0'),
        ]),
        Column(children: [
          Text('欠款金额', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('0.0'),
        ]),
      ],
    );

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          _userCard,
          SizedBox(height: 16),
          _userOverview,
        ],
      ),
    );
  }

  /// 会员信息
  Widget buildCustomerInfo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32),
      color: Colors.white,
      child: Column(
        children: [
          Divider(height: 0),
          ListTile(
            title: Text('最近消费'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Text('2020/02/02'), Icon(Icons.keyboard_arrow_right)],
            ),
          ),
          ListTile(
            title: Text('赊账欠款'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Text('无'), Icon(Icons.keyboard_arrow_right)],
            ),
          ),

          Divider(thickness: 16, color: Color(0xFFF2F2F2)),
          ListTile(
            title: Text('性别'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.keyboard_arrow_right)],
            ),
          ),
          ListTile(
            title: Text('生日'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.keyboard_arrow_right)],
            ),
          ),
          Divider(height: 0),
          ListTile(
            title: Text('地址'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.keyboard_arrow_right)],
            ),
          ),
          Divider(height: 0),
          ListTile(
            title: Text('备注'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.keyboard_arrow_right)],
            ),
          ),
          Divider(thickness: 16, color: Color(0xFFF2F2F2)),
          // ListTile(
          //   title: Text('最近消费'),
          //   trailing: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [Text('2020/02/02'), Icon(Icons.keyboard_arrow_right)],
          //   ),
          // ),
          // Divider(height: 0),
          // ListTile(
          //   title: Text('添加时间'),
          //   trailing: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [Text('2020/02/02'), Icon(Icons.keyboard_arrow_right)],
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: MyAppBar(
        title: '会员详情',
        actions: [
          IconButton(
            onPressed: () => Get.to(() => AddView(uid: id)),
            icon: Icon(Icons.edit, size: 18),
          )
        ],
      ),
      body: GetX<CustomerController>(
        init: CustomerController(),
        initState: (_) {
          controller.addState.findCustomer(id);
        },
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: [
                buildOverview(),
                SizedBox(height: 32),
                buildInfoList(),
                // buildCustomerCard(),
                // buildCustomerInfo(),
                // SizedBox(height: 16),
                // OutlinedButton(
                //   onPressed: () {},
                //   style: ButtonStyle(
                //     backgroundColor:
                //         MaterialStateProperty.all(Colors.red.shade400),
                //     foregroundColor: MaterialStateProperty.all(Colors.white),
                //   ),
                //   child: Text('删除用户'),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildOverview() {
    final infoCard = Container(
      height: 150,
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 28, right: 32, top: 20),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/finance/bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        controller.addState.username,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 16),
                      Text(['', '先生', '女士'][controller.addState.gender]),
                    ],
                  ),
                ),
                Text(controller.addState.getGroupName()),
              ],
            ),
            SizedBox(height: 16),
            Text(controller.addState.telephone),
            SizedBox(height: 32),
            Text('No.00000${controller.addState.addData.value.id}'),
          ],
        ),
      ),
    );
    final infoBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(children: [
          Text('消费金额', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('0.0'),
        ]),
        Column(children: [
          Text('消费次数', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('0'),
        ]),
        Column(children: [
          Text('欠款金额', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('0.0'),
        ]),
      ],
    );
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          infoCard,
          infoBar,
        ],
      ),
    );
  }

  Widget buildInfoList() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: ListTileGroup(customerTitle: SizedBox(), children: [
            ClickTileItem(
              title: '最近消费',
              content: '无',
              onTap: () {},
            ),
            ClickTileItem(
              title: '欠款记录',
              content: '无',
              onTap: () {},
            ),
          ]),
        ),
        SizedBox(height: 16),
        Container(
          color: Colors.white,
          child: ListTileGroup(customerTitle: SizedBox(), children: [
            ClickTileItem(
              title: '性别',
              content: ['保密', '男', '女'][controller.addState.gender],
              arrow: SizedBox(width: 16),
              onTap: () {},
            ),
            ClickTileItem(
              title: '生日',
              content: controller.addState.birthday,
              arrow: SizedBox(width: 16),
              onTap: () {},
            ),
            ClickTileItem(
              title: '地址',
              content: controller.addState.address,
              arrow: SizedBox(width: 16),
              onTap: () {},
            ),
            ClickTileItem(
              title: '备注',
              content: controller.addState.remark,
              arrow: SizedBox(width: 16),
              onTap: () {},
            ),
          ]),
        ),
      ],
    );
  }
}
