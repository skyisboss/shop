import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/payment/views/payment_result.dart';

const _decoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
  ),
);

///头部
Widget buildHeader({required Widget title, bool showClose = true}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        Container(
          height: 5,
          width: 40,
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title,
            showClose
                ? InkWell(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close),
                  )
                : SizedBox()
          ],
        ),
      ],
    ),
  );
}

///接收金额弹窗
buildReceiptBottomSheet() {
  return Container(
    height: 460,
    width: double.infinity,
    decoration: _decoration,
    child: Column(
      children: [
        //头部
        buildHeader(title: Text('接收金额', style: TextStyle(fontSize: 18))),
        Container(
          padding: EdgeInsets.all(16),
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: '0.0',
              label: Text('收到的金额'),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        // Divider(),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 50),
            child: Column(children: [
              Container(
                // margin: EdgeInsets.symmetric(vertical: 16),
                // height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.grey),
                ),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 1,
                  children: List.generate(12, (index) {
                    var num = (index + 1).toString();
                    switch (index) {
                      case 9:
                        num = '0';
                        break;
                      case 10:
                        num = '00';
                        break;
                    }
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: index == 11
                              ? Icon(Icons.backspace)
                              : Text(
                                  num,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(PaymentResultView()),
                  child: Text('确定'),
                ),
              )
            ]),
          ),
        ),
      ],
    ),
  );
}

///电子支付弹出
///信用卡支付弹出
///组合支付弹出
buildMultipleBottomSheet() {
  return Container(
    height: 460,
    width: double.infinity,
    decoration: _decoration,
    child: Column(
      children: [
        buildHeader(title: Text('组合支付', style: TextStyle(fontSize: 20))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              ListTile(
                leading: Text('现金'),
                minLeadingWidth: 60,
                title: Align(
                  alignment: Alignment.centerRight,
                  child: TextField(),
                ),
              ),
              ListTile(
                leading: Text('信用卡'),
                minLeadingWidth: 60,
                title: Align(
                  alignment: Alignment.centerRight,
                  child: TextField(),
                ),
              ),
              ListTile(
                leading: Text('微信'),
                minLeadingWidth: 60,
                title: Align(
                  alignment: Alignment.centerRight,
                  child: TextField(),
                ),
              ),
              ListTile(
                leading: Text('支付宝'),
                minLeadingWidth: 60,
                title: Align(
                  alignment: Alignment.centerRight,
                  child: TextField(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(32),
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child:
                ElevatedButton(onPressed: () => Get.back(), child: Text('确定')),
          ),
        ),
        Expanded(child: SizedBox())
      ],
    ),
  );
}
