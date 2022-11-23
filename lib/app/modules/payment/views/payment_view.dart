import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../widget/payment.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
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
            title: Text('应收款', style: TextStyle(fontSize: 26)),
            amount: Text('￥88.00',
                style: TextStyle(fontSize: 26, color: Colors.red)),
          ),
          Divider(),
          SizedBox(height: 32),
          buildButtonItems(),
          Expanded(child: buildTextItems()),
        ]),
      ),
    );
  }
}
