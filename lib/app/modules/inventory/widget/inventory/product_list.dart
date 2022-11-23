import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/inventory/controllers/inventory_controller.dart';
import 'package:shopkeeper/app/modules/inventory/data/index.dart';
import 'package:shopkeeper/app/modules/inventory/widget/index.dart';

final _controller = Get.find<InventoryController>();

/// 空状态
Widget buildEmptyData() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        'assets/images/common/empty.png',
        width: 100,
        height: 100,
      ),
      SizedBox(height: 16),
      Text(
        '暂无数据',
        style: TextStyle(color: Colors.grey),
      ),
    ],
  );
}

/// 加载中
Widget buildLoading() {
  return Container(
    alignment: Alignment.center,
    child: CircularProgressIndicator(
      color: Colors.grey,
    ),
  );
}

Widget productItem(ProductEntity element, {bool showAction = true}) => Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Image.asset('assets/images/nopic.png', width: 50),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // '我的商品库存title我的商品库存title我的商品库存',
                  element.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // '成本 ￥888',
                            '成本 ￥${element.costPrice.toString()}',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            // '库存 99999',
                            '库存 ${element.totalStock.toString()}',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ]),
                    showAction
                        ? InkWell(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.more_vert, size: 18),
                            ),
                            onTap: () => buildBottomSheet(element),
                          )
                        : SizedBox()
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );

Widget buildSliverSticky(product) {
  return SliverStickyHeader(
    header: Container(
      // height: 30,
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
        ),
      ),
      // child: Center(child: Text('All - (99)')),
    ),
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Column(
          children: [
            productItem(product[index]),
            Divider(indent: 16, endIndent: 16),
          ],
        ),
        childCount: product.length,
      ),
    ),
  );
}

void buildBottomSheet(ProductEntity element) {
  Get.bottomSheet(
    Wrap(
      children: [
        Container(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: productItem(element),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 8),
              ListTile(
                title: Center(child: Text('编辑产品信息')),
                dense: true,
                onTap: () {},
              ),
              Divider(height: 0.5),
              ListTile(
                title: Center(child: Text('调整库存')),
                dense: true,
                onTap: () {},
              ),
              Divider(height: 0.5),
              ListTile(
                title: Center(
                    child: Text(
                  '删除产品',
                  style: TextStyle(color: Colors.red),
                )),
                dense: true,
                onTap: () {},
              ),
              Divider(height: 0.5),
              ListTile(
                title: Center(
                    child: Text(
                  '取消',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )),
                dense: true,
                onTap: () => Get.back(),
              ),
            ],
          ),
        ),
      ],
    ),
    isScrollControlled: true,
  );
}

Widget buildProductList() {
  var product = _controller.isSearch.value
      ? _controller.productState.searchResult
      : _controller.productState.product;
  return Container(
    height: double.maxFinite,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
      ),
    ),
    child: GetX<InventoryController>(
      init: controller,
      initState: (_) {},
      builder: (_) => AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: product.isEmpty
            ? buildEmptyData()
            : CustomScrollView(
                slivers: [
                  buildSliverSticky(product),
                ],
              ),
      ),
    ),
  );
}
