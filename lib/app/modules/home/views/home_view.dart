import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopkeeper/common/style/colors.dart';
import 'package:shopkeeper/widgets/index.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  /// 边框阴影
  final _boxShadow = [
    BoxShadow(
      offset: const Offset(0, 1),
      color: Colors.blue.withOpacity(0.1),
      blurRadius: 10,
    )
  ];

  // App顶部
  Widget buildAppbar() {
    final background = Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/report/bg.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
    final appName = Positioned(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 1),
        child: Text(
          'app_name'.tr,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottom: 0,
    );
    return Stack(
      children: [
        background,
        appName,
      ],
    );
  }

  // 信息概览
  Widget buildOverviewInfo() {
    final background = Container(
      height: 120,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/report/bg1.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
    final _infoData = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...controller.overviewList.map(
          (item) => TotalItem(
            title: item['title'],
            image: item['image'],
            content: item['content'],
          ),
        )
      ],
    );

    final infoCard = Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
          topRight: Radius.circular(3),
          bottomLeft: Radius.circular(3),
        ),
        boxShadow: _boxShadow,
      ),
      child: _infoData,
    );

    return Stack(
      children: [
        background,
        infoCard,
      ],
    );
  }

  /// 教程提示
  Widget buildTutorial() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: _boxShadow,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(Icons.volume_up, size: 18),
          SizedBox(width: 8),
          Expanded(child: Text(controller.tutorialText)),
          Icon(Icons.keyboard_arrow_right, size: 18, color: Colors.grey),
        ],
      ),
    );
  }

  // 功能卡片
  Widget buildActionCard() {
    // 功能导航点击按钮
    Widget _clickItem(Map action) {
      return InkWell(
        onTap: () => Get.toNamed(action['link']),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              action['icon'],
              size: 34,
              // color: MyColors.primaryColor.withOpacity(.6), //Color(0xFF8080FF),
              color: Colors.orange.shade600, //Color(0xFF8080FF),
            ),
            SizedBox(height: 6),
            Text(
              action['label'],
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      );
    }

    final navsCard = GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.2, //1.953,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: controller.actionList.length,
      itemBuilder: (_, index) {
        var action = controller.actionList[index];
        return _clickItem(action);
      },
    );
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: _boxShadow,
        borderRadius: BorderRadius.circular(30),
      ),
      child: navsCard,
    );
  }

  // app名称
  Widget buildAppName() {
    return Container(
      // margin: EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Shopkeeper',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade200,
            ),
          ),
          /*
            SizedBox(width: 5),
            Text(
              '1.0.1',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade200,
              ),
            )*/
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildAppbar(),
            buildOverviewInfo(),
            SizedBox(height: 8),
            buildTutorial(),
            buildActionCard(),
            SizedBox(height: 8),
            buildAppName(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
