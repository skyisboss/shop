import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/routes/app_pages.dart';
import 'package:shopkeeper/common/style/colors.dart';
import 'package:shopkeeper/widgets/index.dart';
import 'dart:math' as math;

class PrintView extends StatelessWidget {
  const PrintView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: MyAppBar(
        leading: SizedBox(),
        title: '收据',
        centerTitle: false,
        leadingWidth: 8,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.mobile_screen_share))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: buildTicketPaper(context),
            ),
          ),
          Container(
            height: 57,
            width: double.maxFinite,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('打印'),
                ),
                TextButton(
                  onPressed: () => Get.offAndToNamed(Routes.HOME),
                  child: Text('完成'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTicketPaper(context) {
    final _width = MediaQuery.of(context).size.width;
    final _size = ((_width - 40) / 12).floorToDouble();
    final _triangleHead = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_size.toInt(), (index) => buildTriangle()),
    );
    final contactInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('店铺名称'),
        Text('联系电话'),
        Text('联系地址'),
      ],
    );
    final receiptInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('流水: 202202011158'),
        Text('日期: 2022/02/02 15:16'),
      ],
    );
    final orderInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('数量'),
          Text('单价'),
          Text('总计'),
        ]),
        SizedBox(height: 6),
        ...List.generate(10, (index) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('老谭酸菜'),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('x 8'),
                    Text('8.00'),
                    Text('88.00'),
                  ],
                ),
                SizedBox(height: 8),
              ]);
        }),
      ],
    );

    final totalInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('共 8 项'),
        Text('总计 888.00'),
      ],
    );

    return Column(
      children: [
        // _triangleHead,
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              SizedBox(width: double.infinity, child: contactInfo),
              Divider(),
              SizedBox(width: double.infinity, child: receiptInfo),
              Divider(),
              SizedBox(width: double.infinity, child: orderInfo),
              Divider(),
              SizedBox(width: double.infinity, child: totalInfo),
              Divider(),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('收款 888'),
                    Text('找零 0.00'),
                  ],
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(math.pi),
          child: _triangleHead,
        ),
      ],
    );
  }

  // 三角形锯齿
  Widget buildTriangle() {
    return Container(
      width: 12,
      height: 0,
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border(
          // 四个值 top right bottom left
          bottom: BorderSide(
              color: Colors.white, width: 6, style: BorderStyle.solid),
          right: BorderSide(
              color: Colors.transparent, width: 6, style: BorderStyle.solid),
          left: BorderSide(
              color: Colors.transparent, width: 6, style: BorderStyle.solid),
        ),
      ),
    );
  }
}
