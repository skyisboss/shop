import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/widgets/index.dart';

import '../export.dart';
import 'pay_view.dart';

class CartView extends GetView<PosController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leadingWidth: 0,
        centerTitle: false,
        title: Text(
          '购物车',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 8),
            child: TextButton(
              onPressed: () => popupScanerConfirm(),
              child: Row(
                children: [
                  Text('扫码选购'),
                  SizedBox(width: 4),
                  Icon(Icons.add_shopping_cart, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      body: GetX<PosController>(
        init: PosController(),
        initState: (_) {},
        builder: (_) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTileGroup(
                        title: '订单信息',
                        titleSize: 18,
                        showBorder: false,
                        children: [
                          buildOrderInfo(),
                        ],
                      ),
                      SizedBox(height: 16),
                      ListTileGroup(
                        title: '收款信息',
                        titleSize: 18,
                        showBorder: false,
                        children: [
                          buildPriceInfo(),
                        ],
                      ),
                      Divider(),
                      SizedBox(height: 32),
                      buildActions(),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
              buildButtomBar(),
            ],
          );
        },
      ),
    );
  }

  // 点击扫码时弹出询问
  popupScanerConfirm() {
    final active = [false, false].obs;
    cupertinoDialog(
      Get.context as BuildContext,
      title: Text('请选择'),
      content: Obx(
        () => Column(children: [
          SizedBox(height: 8),
          ListTile(
            onTap: () {
              active.value = [false, false];
              active[0] = true;
            },
            selected: active[0],
            leading: Icon(Icons.auto_fix_high),
            title: Text('扫描器'),
            trailing: active[0] ? Icon(Icons.check) : null,
          ),
          ListTile(
            onTap: () {
              active.value = [false, false];
              active[1] = true;
            },
            selected: active[1],
            leading: Icon(Icons.photo_camera),
            title: Text('相机'),
            trailing: active[1] ? Icon(Icons.check) : null,
          ),
        ]),
      ),
      onConfirm: () {},
    );
  }

  Widget buildActions() {
    _buildButton(String title, IconData icon, Function() ontap) =>
        OutlinedButton(
          onPressed: ontap,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade200),
          ),
          child: Column(children: [
            SizedBox(height: 8),
            Icon(icon),
            Text(title),
            SizedBox(height: 8),
          ]),
        );
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _buildButton('配送费', Icons.local_shipping_outlined, () {
        controller.orderState.handleFee(0);
      }),
      _buildButton('服务费', Icons.content_paste, () {
        controller.orderState.handleFee(1);
      }),
      _buildButton('折扣', Icons.local_offer_outlined, () {}),
    ]);
  }

  Widget buildPriceInfo() {
    var order = controller.orderState;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('共 ${order.orderItemTotal} 项'),
            Text('${order.orderPriceTotal}')
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('配送费'), Text('${order.deliveryFee}')],
        ),
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('服务费'), Text('${order.serviceFee}')],
        ),
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('优惠折扣'), Text('${order.discountFee}')],
        ),
        SizedBox(height: 16),
        DefaultTextStyle(
          style: TextStyle(fontSize: 22, color: Colors.black87),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('应收款'),
              Text('${order.payableAmount}'),
            ],
          ),
        ),
      ]),
    );
  }

  Widget buildOrderInfo() {
    buildListTile(OrderListEntity element) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          dense: true,
          leading: Image.asset('assets/images/nopic.png'),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(element.data.title),
          ),
          subtitle: ToggleButtons(
            fillColor: Colors.blue.withOpacity(0.04),
            borderRadius: BorderRadius.circular(50.0),
            constraints: BoxConstraints(minHeight: 30.0),
            isSelected: [false, false, false],
            onPressed: (index) {
              switch (index) {
                case 0:
                  controller.orderState
                      .removeOrder(id: element.id, element: element.data);
                  break;
                case 1:
                  controller.orderState
                      .typeOrder(id: element.id, element: element.data);
                  break;
                case 2:
                  controller.orderState
                      .addOrder(id: element.id, element: element.data);
                  break;
              }
            },
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(Icons.remove),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'x ${element.total}',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(Icons.add),
              ),
            ],
          ),
          trailing: Text('${element.data.salePrice}'),
        ),
      );
    }

    return controller.orderState.orderGoodsList.isEmpty
        ? Center(
            child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: EmptyStatus(label: '暂无订单信息，请选购'),
          ))
        : Column(
            children: [
              ...controller.orderState.orderGoodsList.map((element) {
                return Column(
                  children: [
                    buildListTile(element),
                    Divider(),
                  ],
                );
              }),
            ],
          );
  }

  Widget buildButtomBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      width: double.infinity,
      height: 57,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ToggleButtons(
            fillColor: Colors.blue.withOpacity(0.04),
            borderRadius: BorderRadius.circular(50.0),
            constraints: BoxConstraints(minHeight: 36.0),
            isSelected: [false, false],
            onPressed: (index) {
              Get.back();
            },
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('取消本单', style: TextStyle(color: Colors.red)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('稍后付款', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          // TextButton(onPressed: () {}, child: Text('订单作废')),
          // //选购信息
          // TextButton(onPressed: () => Get.back(), child: Text('稍后付款')),
          //结算按钮
          ElevatedButton(
            onPressed: () => Get.to(() => PayView()),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
              ),
            ),
            child: Row(
              children: [
                Text('去结算'),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
