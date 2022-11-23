import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/pos/widget/pos/drop_category.dart';
import 'package:shopkeeper/app/modules/pos/widget/pos/drop_down_menu.dart';
import 'package:shopkeeper/common/values/colors.dart';
import 'package:shopkeeper/widgets/easy_popup/easy_popup.dart';

final dataListIndex = 0.obs;
final List dataList = [
  {'id': 1, 'title': '表单名称1', 'count': 0.obs},
  {'id': 2, 'title': '表单名称2', 'count': 0.obs},
  {'id': 3, 'title': '表单名称3', 'count': 0.obs},
  {'id': 4, 'title': '表单名称3', 'count': 0.obs},
  {'id': 5, 'title': '表单名称3', 'count': 0.obs},
  {'id': 6, 'title': '表单名称3', 'count': 0.obs},
  {'id': 7, 'title': '表单名称3', 'count': 0.obs},
  {'id': 8, 'title': '表单名称3', 'count': 0.obs},
  {'id': 9, 'title': '表单名称3', 'count': 0.obs},
  {'id': 10, 'title': '表单名称3', 'count': 0.obs},
  {'id': 11, 'title': '表单名称3', 'count': 0.obs},
  {'id': 12, 'title': '表单名称12', 'count': 0.obs},
  {'id': 12, 'title': '表单名称12', 'count': 0.obs},
  {'id': 12, 'title': '表单名称12', 'count': 0.obs},
  {'id': 12, 'title': '表单名称12', 'count': 0.obs},
  {'id': 12, 'title': '表单名称12', 'count': 0.obs},
  {'id': 12, 'title': '表单名称12', 'count': 0.obs},
  {'id': 12, 'title': '表单名称12', 'count': 0.obs},
  {'id': 12, 'title': '表单名称12', 'count': 0.obs},
];
final isClick = true.obs;
final showSearch = false.obs;
var searchController = TextEditingController();

/// 标题栏
Widget buildSliverAppBar(size) {
  Widget buildSearch() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }

  return SliverAppBar(
    pinned: true,
    elevation: 0.5,
    expandedHeight: 100.0,
    actions: [
      IconButton(
        onPressed: () {
          print('object');
          showSearch.value = !showSearch.value;
        },
        icon: Obx(() => Icon(showSearch.value ? Icons.close : Icons.search)),
      )
    ],
    centerTitle: true, //
    flexibleSpace: Obx(() => FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: showSearch.value
              ? EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 6)
              : EdgeInsetsDirectional.all(14),
          title: showSearch.value
              ? buildSearch()
              : InkWell(
                  onTap: () => buildCategoryList(size),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      child: Text(
                        dataList[dataListIndex.value]['title'],
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, size: 16),
                  ]),
                ),
        )),
    foregroundColor: Colors.black87,
    backgroundColor: Colors.white,
  );
}

/// buttomsheet
buildCategoryList(size) {
  //SingleChildScrollView
  return Get.bottomSheet(
    Container(
      height: size.height * 0.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              width: 100,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 32),
              child: Column(
                children: List.generate(dataList.length, (index) {
                  return Column(
                    children: [
                      Divider(
                        thickness: 0.5,
                        height: 1,
                      ),
                      ListTile(
                        onTap: () {
                          dataListIndex.value = index;
                          Get.back();
                        },
                        dense: true,
                        // visualDensity: VisualDensity(vertical: -3),
                        title: Text(dataList[index]['title']),
                        trailing: Text('$index'),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}

/// 滚动列表 -列表排列
Widget buildSliverList() {
  // 列表排列
  return SliverFixedExtentList(
    itemExtent: 110,
    delegate: SliverChildBuilderDelegate(
      (_, index) => ListTile(
        leading: Stack(
          children: [
            Icon(
              Icons.image,
              size: 90,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(6),
              child: Text('1'),
            )
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dataList[index]['title']),
            SizedBox(height: 20),
            Text('￥ 999.00'),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ),
      ),
      childCount: dataList.length,
    ),
  );
}

/// 滚动列表 -表格排序
Widget buildSliverGrid() {
  return SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    sliver: SliverGrid(
      //Grid
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, //Grid按两列显示
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 3 / 4,
        // childAspectRatio: 4,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          var _item = dataList[index];
          var _itemCount = dataList[index]['count'];

          //创建子widget
          return InkWell(
            onTap: () {
              _itemCount.value++;
            },
            child: Obx(() => Container(
                  // height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: _itemCount.value == 0
                          ? Colors.grey.shade200
                          : MyColor.primaryColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Stack(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Image.asset(
                              'assets/images/nopic.png',
                              // width: 80.0,
                            ),
                          ),
                        ),

                        /// 选中数量
                        InkWell(
                          onTap: () {
                            if (_itemCount.value > 0) {
                              _itemCount.value--;
                            }
                          },
                          child: Obx(() => _itemCount.value == 0
                              ? SizedBox()
                              : Container(
                                  decoration: BoxDecoration(
                                    color: MyColor.primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(
                                    dataList[index]['count'].value.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                        ),
                      ]),
                      Text(
                        'grid itemgrid itemgrid itegrid itemgrid itemgrid item ',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )),
          );
        },
        childCount: dataList.length,
      ),
    ),
  );
}

/// 主要内容区
final alpha = 0.0.obs;
final _height = 150.0.obs;
final _curr = 0.0.obs;
final _isOpen = false.obs;
final appbar_height = AppBar().preferredSize.height;
Widget buildContentView(size) {
  ScrollController _controller = ScrollController();

  _controller.addListener(() {
    // print(_controller.offset);
    // _curr.value = _controller.offset;
    double _alpha = _controller.offset / 100;
    if (_alpha >= 0.65) {
      alpha.value = 1.0;
    } else {
      alpha.value = 0.0;
    }
  });

  // final isOpen = false.obs;
  return CustomScrollView(
    controller: _controller,
    slivers: [
      // buildSliverAppBar(size),
      // buildSliverList(),

      SliverAppBar(
        pinned: true,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                if (!_isOpen.value) {
                  _curr.value = _controller.offset;
                  _controller.jumpTo(0);
                  _height.value = 500;
                } else {
                  _controller.jumpTo(_curr.value);
                  _height.value = 150;
                  // _controller.animateTo(_curr.value,
                  //     duration: Duration(milliseconds: 100),
                  //     curve: Curves.linear);
                }
                _isOpen.value = !_isOpen.value;
              },
              icon: Icon(Icons.qr_code_scanner))
        ],
        floating: true,
        title: Obx(
          () => Opacity(
              opacity: alpha.value,
              child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('全部分类'), Icon(Icons.keyboard_arrow_down)],
                ),
              )),
        ),
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      SliverToBoxAdapter(
        child: Obx(
          () => AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: _height.value,
            // color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    '全部分类',
                    maxLines: 1,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      buildSliverGrid(),
    ],
  );
}

_showDropDownMenu(context) {
  print(MediaQuery.of(context).viewPadding);
  EasyPopup.show(context, DropDownMenu(),
      offsetLT: Offset(0,
          MediaQuery.of(context).padding.top + AppBar().preferredSize.height));
}

/// 底部卡片
Widget buildBottomCard(context) {
  final isScan = false.obs;
  Widget buildScanStateCard() {
    return Container(
      // height: 50,
      width: double.infinity,
      padding: EdgeInsets.all(8),
      color: Colors.grey.shade200,
      child: Center(
        child: Text(
          '等待扫码信息',
          style: TextStyle(color: Colors.red, fontSize: 20),
        ),
      ),
    );
  }

  return Column(
    children: [
      Obx(() => isScan.value ? buildScanStateCard() : SizedBox()),
      Divider(thickness: 0.5, height: 1),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: double.infinity,
        height: 60,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('共 8 件'),
                  Text('合计 ￥800008.00', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
            // Text('data')
            ToggleButtons(
              // color: Colors.red,
              // selectedColor: Colors.blue,
              // selectedBorderColor: Colors.blue,
              // borderColor: Colors.red,
              fillColor: Colors.blue.withOpacity(0.04),
              borderRadius: BorderRadius.circular(50.0),
              constraints: BoxConstraints(minHeight: 36.0),
              onPressed: (index) {
                if (index == 0) {
                  isScan.value = !isScan.value;
                  _showDropDownMenu(context);
                }
              },
              isSelected: [true, false],
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        // Icon(Icons.add),
                        Text('扫码'),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    children: [
                      Text('结算'),
                      // Icon(Icons.add),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
