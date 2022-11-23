import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopkeeper/app/routes/app_pages.dart';
import 'package:shopkeeper/common/values/index.dart';

import '../controllers/check_cart_controller.dart';

class CheckCartView extends GetView<CheckCartController> {
  buildBottomBar() {
    return Column(
      children: [
        Divider(thickness: 0.5, height: 1),
        Container(
          height: 60,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text('继续选购'),
              // ),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text('扫码'),
              // ),
              ToggleButtons(
                fillColor: Colors.blue.withOpacity(0.04),
                borderRadius: BorderRadius.circular(50.0),
                constraints: BoxConstraints(minHeight: 36.0),
                isSelected: [false, false],
                onPressed: (index) {
                  if (index == 0) {
                    Get.back();
                  } else {}
                },
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('选购'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('扫码'),
                  ),
                ],
              ),
              SizedBox(width: 32),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.PAYMENT);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('去付款'),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildPageContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //订单信息
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '订单信息',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Image.asset('assets/images/nopic.png'),
            title: Text('200ml 可口可乐可口可乐可'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 10),
                Text('250ML'),
                Text('￥88.00'),
              ],
            ),
            trailing: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  child: Text('x 199'),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Image.asset('assets/images/nopic.png'),
            title: Text('200ml 可口可乐可口可乐可'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 14),
                Text('￥88.00'),
              ],
            ),
            trailing: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  // color: Colors.blue,
                  child: Text('x 1'),
                ),
              ],
            ),
          ),
          //订单统计
          Divider(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('共计 2 项'), Text('￥ 88.00')]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(
                            Icons.edit,
                            size: 14,
                          ),
                          SizedBox(width: 8),
                          Text('配送费'),
                        ]),
                        Text('￥ 88.00'),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(
                            Icons.edit,
                            size: 14,
                          ),
                          SizedBox(width: 8),
                          Text('服务费'),
                        ]),
                        Text('￥ 88.00')
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(
                            Icons.edit,
                            size: 14,
                          ),
                          SizedBox(width: 8),
                          Text('优惠/折扣'),
                        ]),
                        Text('￥ 88.00')
                      ]),
                ),
              ],
            ),
          ),
          // Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '应收款',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '￥88.00',
                    style: TextStyle(fontSize: 20),
                  ),
                ]),
          ),
          //订单信息
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '订单信息',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(children: [
                  Text('订单编号：', style: TextStyle(color: Colors.grey.shade700)),
                  Text('88.00'),
                ]),
                Row(children: [
                  Text('下单时间：', style: TextStyle(color: Colors.grey.shade700)),
                  Text('2022/02/02 15/20'),
                ]),
                Row(children: [
                  Text('配送方式：', style: TextStyle(color: Colors.grey.shade700)),
                  Text('无'),
                ]),
                Row(children: [
                  Text('备        注：',
                      style: TextStyle(color: Colors.grey.shade700)),
                  Text('无'),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('稍后付款', style: TextStyle(color: Colors.black54)),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: buildPageContent(),
          ),
          buildBottomBar(),
        ],
      ),
    );
  }
}
