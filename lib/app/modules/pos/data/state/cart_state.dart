// 购物车
import 'package:get/get.dart';
import 'package:shopkeeper/widgets/index.dart';

class CartState {
  //购物车商品
  final _cartGoodsList = <Map<String, int>>[].obs;
  RxList<Map<String, int>> get cartGoodsList => _cartGoodsList;
  // 购物车商品数量
  final _totalItem = 0.obs;
  int get totalCartItem => _totalItem.value;

  int hasCartGoods(int id) => cartGoodsList.indexWhere((e) => e['id'] == id);

  addCartGoods(int id) {
    var index = hasCartGoods(id);

    if (index < 0) {
      _cartGoodsList.add({
        'id': id,
        'num': 1,
      });
    } else {
      _cartGoodsList[index]['num'] = (_cartGoodsList[index]['num']! + 1);
    }
    _totalItem.value++;
    print(_cartGoodsList);
  }

  removeCartGoods(int index) {
    _cartGoodsList[index]['num'] = (_cartGoodsList[index]['num']! - 1);
    if (_cartGoodsList[index]['num'] == 0) {
      _cartGoodsList.removeAt(index);
    }
    _cartGoodsList.refresh();
    _totalItem.value--;
  }
}
