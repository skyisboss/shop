import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/routes/app_pages.dart';
import './print_receipt.dart';
import '../widget/payment.dart';

class PaymentResultView extends StatelessWidget {
  const PaymentResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: SizedBox(),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          buildReceiptAmount(
            title: Text('应收款', style: TextStyle(fontSize: 22)),
            amount: Text('￥88.00',
                style: TextStyle(fontSize: 26, color: Colors.red)),
          ),
          Divider(),
          SizedBox(height: 16),
          buildReceiptAmount(
            title: Text('实收款', style: TextStyle(fontSize: 22)),
            amount: Text('￥88.00',
                style: TextStyle(fontSize: 26, color: Colors.blue)),
          ),
          Divider(),
          SizedBox(height: 16),
          buildReceiptAmount(
            title: Text('找零', style: TextStyle(fontSize: 22)),
            amount: Text('￥88.00',
                style: TextStyle(fontSize: 26, color: Colors.green)),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => Get.offAll(PrintReceiptView()),
                    child: Text('打印票据'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => Get.offAllNamed(Routes.POS),
                    child: Text('完成'),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
