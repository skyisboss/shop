import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/pos/export.dart';
import 'package:shopkeeper/app/routes/app_pages.dart';
import 'package:shopkeeper/widgets/index.dart';

import 'print_view.dart';

class PayView extends GetView<PosController> {
  const PayView({Key? key}) : super(key: key);

  final done = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        leading: SizedBox(),
      ),
      body: GetX<PosController>(
        init: PosController(),
        initState: (_) {
          controller.orderState.isPaymentDone = false;
        },
        builder: (_) {
          return Container(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildAmountInfo(),
                SizedBox(height: 32),
                buildButtonList(),
                Spacer(),
                buildBottom(),
                SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  // 数字键盘
  Widget buildNumberKeyBord(Function(String) onTap) {
    return Container(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: 12,
        itemBuilder: (_, index) {
          Widget box = SizedBox();
          var numberText = index + 1;
          switch (index) {
            case 9:
              break;
            case 11:
              // box = InkWell(
              //   onTap: () {},
              //   child: Center(
              //     child: Padding(
              //       padding: const EdgeInsets.only(top: 6),
              //       child: Icon(
              //         Icons.backspace,
              //         color: Colors.grey.shade400,
              //       ),
              //     ),
              //   ),
              // );
              break;
            default:
              numberText = numberText == 11 ? 0 : numberText;
              box = InkWell(
                onTap: () {
                  onTap(numberText.toString());
                },
                child: Center(
                  child: Text(
                    numberText.toString(),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
          }
          return box;
        },
      ),
    );
  }

  // 弹窗接收金额
  popupReceiveView(String title) {
    final header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close))
      ],
    );
    final textController = TextEditingController();
    final focusNode = FocusNode();
    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Wrap(children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: header,
          ),
          // 主体部分
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
            child: SizedBox(
              height: 44,
              child: TextField(
                focusNode: focusNode,
                controller: textController,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.red),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: '接收金额',
                  hintStyle: TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                ),
              ),
            ),
          ),
          buildNumberKeyBord((e) {
            textController.text += e.toString();
          }),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Container(
              height: 40,
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton(
                onPressed: () {
                  if (textController.text.isEmpty) {
                    focusNode.requestFocus();
                  } else {
                    Get.back(result: textController.text);
                  }
                },
                child: Text('OK'),
              ),
            ),
          ),
        ]),
      ),
      isScrollControlled: true,
    );
  }

  buildAmountInfo() {
    var order = controller.orderState;
    return DefaultTextStyle(
      style: TextStyle(fontSize: 26, color: Colors.black87),
      child: Column(
        children: [
          Text('应收款'),
          Text('+ ${order.payableAmount}',
              style: TextStyle(color: Colors.blue)),
          SizedBox(height: 16),
          Divider(),
          controller.orderState.isPaymentDone
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(children: [
                      SizedBox(height: 16),
                      Text('实收'),
                      Text('${order.receiveAmount}',
                          style: TextStyle(color: Colors.green)),
                    ]),
                    Column(children: [
                      SizedBox(height: 16),
                      Text('找零'),
                      Text('${order.changeAmount}',
                          style: TextStyle(color: Colors.deepOrangeAccent)),
                    ]),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }

  buildButtonList() {
    handleReceive(String title) async {
      var result = await popupReceiveView(title);
      if (result != null) {
        controller.orderState.receiveAmount = double.parse(result);
        controller.orderState.isPaymentDone = true;
      }
    }

    return controller.orderState.isPaymentDone
        ? SizedBox()
        : Column(
            children: [
              Container(
                height: 40,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: ElevatedButton(
                    onPressed: () => handleReceive('现金收款'),
                    child: Text('现金收款')),
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: ElevatedButton(
                    onPressed: () => handleReceive('刷卡收款'),
                    child: Text('刷卡收款')),
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: ElevatedButton(
                    onPressed: () => handleReceive('组合收款'),
                    child: Text('组合收款')),
              ),
            ],
          );
  }

  buildBottom() {
    return controller.orderState.isPaymentDone
        ? Column(
            children: [
              Container(
                height: 40,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: OutlinedButton(
                  onPressed: () => controller.orderState.isPaymentDone = false,
                  child: Text('完成'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue.shade50),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: ElevatedButton(
                    onPressed: () => Get.to(() => PrintView()),
                    child: Text('打印票据')),
              )
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                child: Text('取消本单', style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () {},
                child: Text('稍后付款'),
              ),
            ],
          );
  }
}
