import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/pos/widget/pos/drop_down_menu.dart';
import 'package:shopkeeper/app/routes/app_pages.dart';
import 'package:shopkeeper/common/values/index.dart';
import 'package:shopkeeper/widgets/easy_popup/easy_popup.dart';

SliverAppBar __buildSliverAppBar(context) {
  return SliverAppBar(
    pinned: true,
    centerTitle: true,
    elevation: 0.5,
    foregroundColor: Colors.black87,
    backgroundColor: Colors.white,
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.search),
      )
    ],
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        // 如果选购车是空的则直接返回上页,否则弹出提醒
        if (totalGoods.value > 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("确定返回吗"),
                content: const Text("选购信息将会清空"),
                actions: [
                  TextButton(onPressed: () => Get.back(), child: Text('取消')),
                  TextButton(
                      onPressed: () {
                        Get.back();
                        totalGoods.value = 0;
                        Get.back();
                      },
                      child: Text('确定')),
                ],
              );
            },
          );
        } else {
          Get.back();
        }
      },
    ),
    title: InkWell(
      onTap: () {
        // print('object');
        EasyPopup.show(context, DropDownMenu(),
            offsetLT: Offset(
                0,
                MediaQuery.of(context).padding.top +
                    AppBar().preferredSize.height));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              // width: 260,
              child: Text(
                '全部分类',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black87),
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.keyboard_arrow_down, size: 16),
          ],
        ),
      ),
    ),
  );
}

Widget __buildSliverToBoxAdapter() {
  return SliverAppBar();
}

final totalGoods = 0.obs;
final totalPrice = 0.obs;
final List items = [
  {'id': 1, 'title': '表单名称1', 'select': 0.obs},
  {'id': 2, 'title': '表单名称2', 'select': 0.obs},
  {'id': 3, 'title': '表单名称3', 'select': 0.obs},
  {'id': 4, 'title': '表单名称3', 'select': 0.obs},
  {'id': 5, 'title': '表单名称3', 'select': 0.obs},
  {'id': 6, 'title': '表单名称3', 'select': 0.obs},
  {'id': 7, 'title': '表单名称3', 'select': 0.obs},
  {'id': 8, 'title': '表单名称3', 'select': 0.obs},
  {'id': 9, 'title': '表单名称3', 'select': 0.obs},
  {'id': 10, 'title': '表单名称3', 'select': 0.obs},
  {'id': 11, 'title': '表单名称3', 'select': 0.obs},
  {'id': 12, 'title': '表单名称12', 'select': 0.obs},
  {'id': 12, 'title': '表单名称12', 'select': 0.obs},
  {'id': 12, 'title': '表单名称12', 'select': 0.obs},
  {'id': 12, 'title': '表单名称12', 'select': 0.obs},
  {'id': 12, 'title': '表单名称12', 'select': 0.obs},
  {'id': 12, 'title': '表单名称12', 'select': 0.obs},
  {'id': 12, 'title': '表单名称12', 'select': 0.obs},
  {'id': 12, 'title': '表单名称12', 'select': 0.obs},
];

Widget __buildSliverGrid() {
  Widget _buildItem(int index) {
    var item = items[index];
    var buyNum = items[index]['select'].value;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Stack(
        children: [
          // 图片和描述信息
          Container(
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            child: InkWell(
              onTap: () {
                items[index]['select'].value++;
                totalGoods.value++;
              },
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Container(
                // padding: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    color: buyNum == 0
                        ? Colors.grey.shade200
                        : MyColor.primaryColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/nopic.png',
                      // width: 80.0,
                    ),
                    Text('￥888888888.00',
                        overflow: TextOverflow.ellipsis, maxLines: 1),
                    Text(item['title'],
                        overflow: TextOverflow.ellipsis, maxLines: 1),
                  ],
                ),
              ),
            ),
          ),

          /// 显示选中数量
          buyNum > 0
              ? InkWell(
                  /// 按下时控制图片 container 的边框
                  onTap: () {
                    if (items[index]['select'].value > 0) {
                      items[index]['select'].value--;
                      totalGoods.value--;
                    }
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: MyStyle.boxDecoration,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      buyNum.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  return SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    sliver: SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, //Grid按两列显示
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 3 / 4,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => Obx(() => _buildItem(index)),
        childCount: items.length,
      ),
    ),
  );
}

Widget buildContentPanel(context) {
  return Expanded(
    child: CustomScrollView(slivers: [
      __buildSliverAppBar(context),
      __buildSliverGrid(),
    ]),
  );
}

Widget buildBottomPanel() {
  return Column(children: [
    Divider(thickness: 0.5, height: 1),
    Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      height: 60,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 选购信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('共 '),
                    Obx(
                      () => Text('${totalGoods.value}',
                          style: TextStyle(color: Colors.red)),
                    ),
                    Text(' 件'),
                  ],
                ),
                Text('合计 ￥800008.00', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.CHECK_CART);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                ),
              ),
              child: Row(
                children: [
                  Text('去结算'),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward),
                ],
              )),

          ///结算按钮
          // ToggleButtons(
          //   fillColor: Colors.blue.withOpacity(0.04),
          //   borderRadius: BorderRadius.circular(50.0),
          //   constraints: BoxConstraints(minHeight: 36.0),
          //   isSelected: [true],
          //   onPressed: (index) {},
          //   children: [
          //     Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 36.0),
          //       child: Row(
          //         children: [
          //           Text('结算'),
          //           SizedBox(width: 10),
          //           Icon(Icons.arrow_forward),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    ),
  ]);
}
