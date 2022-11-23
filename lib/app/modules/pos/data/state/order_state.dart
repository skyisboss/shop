import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/product/data/export.dart';
import 'package:shopkeeper/widgets/index.dart';

class OrderState {
  // 购物车商品总数
  final _orderItemTotal = 0.obs;
  int get orderItemTotal => _orderItemTotal.value;
  // 购物车商品价格总数
  final _orderPriceTotal = 0.0.obs;
  double get orderPriceTotal => _orderPriceTotal.value;
  // 配送费
  final _deliveryFee = 0.0.obs;
  double get deliveryFee => _deliveryFee.value;
  // 服务费
  final _serviceFee = 0.0.obs;
  double get serviceFee => _serviceFee.value;
  // 优惠金额
  final _discountFee = 0.0.obs;
  double get discountFee => _discountFee.value;
  // 应收款
  final _payableAmount = 0.0.obs;
  double get payableAmount =>
      orderPriceTotal - (deliveryFee + serviceFee + discountFee);
  // _payableAmount.value;
  // 实收款
  final _receiveAmount = 0.0.obs;
  set receiveAmount(val) => _receiveAmount.value = val;
  double get receiveAmount => _receiveAmount.value;
  // 找零
  final _changeAmount = 0.0.obs;
  set changeAmount(val) => _changeAmount.value = val;
  double get changeAmount => _changeAmount.value;

  // 是否完成收款
  final _isPaymentDone = false.obs;
  set isPaymentDone(val) => _isPaymentDone.value = val;
  bool get isPaymentDone => _isPaymentDone.value;

  // 选购的商品
  final _orderGoodsList = <OrderListEntity>[].obs;
  RxList<OrderListEntity> get orderGoodsList => _orderGoodsList;

  // 通过id查询商品是否存在购物车
  int existOrder(int id) => orderGoodsList.isNotEmpty
      ? orderGoodsList.indexWhere((e) => e.id == id)
      : -1;

  //加入购物车
  addOrder({required int id, required ProductEntity element}) {
    var index = existOrder(id);
    if (index < 0) {
      orderGoodsList.add(OrderListEntity(id: id, total: 1, data: element));
    } else {
      orderGoodsList[index].total += 1;
    }
    orderGoodsList.refresh();
    _orderItemTotal.value++;
    _orderPriceTotal.value += element.salePrice!;
  }

  removeOrder({required int id, required ProductEntity element}) {
    for (var i = 0; i < orderGoodsList.length; i++) {
      var item = orderGoodsList[i];
      if (item.id == id) {
        item.total -= 1;
        if (item.total == 0) {
          orderGoodsList.removeAt(i);
        }
        orderGoodsList.refresh();
        _orderItemTotal.value--;
        _orderPriceTotal.value -= element.salePrice!;
        break;
      }
    }
  }

  typeOrder({required int id, required ProductEntity element}) {
    popupDialog(
      title: '输入数量',
      onTap: (e) {
        if (e.isNotEmpty) {
          var total = int.parse(e);
          if (total == 0) {
            removeOrder(id: id, element: element);
            return;
          }
          var index = existOrder(id);
          orderGoodsList[index].total = total;
          _orderItemTotal.value = total;
          _orderPriceTotal.value = (element.salePrice! * total);
        }
      },
    );
  }

  // 配送服务费用
  handleFee(int type) {
    var text = ['输入配送费', '输入服务费'];
    popupDialog(
      title: text[type],
      onTap: (e) {},
    );
  }

  // 折扣
  handleDiscount() {}

  popupDialog({required String title, required Function(String) onTap}) {
    var textController = TextEditingController();
    final inputContent = Material(
      color: Colors.transparent,
      child: Container(
        height: 40,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          controller: textController,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
            hintText: title,
            hintStyle: TextStyle(fontSize: 13),
            filled: true,
            fillColor: Colors.grey.shade300,
            contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
      ),
    );
    cupertinoDialog(
      Get.context as BuildContext,
      title: Text(title),
      content: inputContent,
      onConfirm: () => onTap(textController.text),
    );
  }
}

class OrderListEntity {
  OrderListEntity({
    required this.id,
    required this.total,
    required this.data,
  });

  int id;
  int total;
  ProductEntity data;

  factory OrderListEntity.fromJson(Map<String, dynamic> json) =>
      OrderListEntity(
        id: json["id"],
        total: json["total"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
        "data": data,
      };
}
