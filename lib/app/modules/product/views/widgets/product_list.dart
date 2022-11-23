import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/product/controllers/product_controller.dart';
import 'package:shopkeeper/app/modules/product/data/export.dart';
import 'package:shopkeeper/common/style/colors.dart';

import '../edit_product.dart';

class ProductList extends StatelessWidget {
  ProductList({Key? key}) : super(key: key);
  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    final listEndTips = SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Text(
          '已经到底了',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade400),
        ),
      ),
    );

    return GetX<ProductController>(
      init: controller,
      initState: (_) {},
      builder: (value) {
        return Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
              ),
            ),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 180),
              child: loadData(
                child: CustomScrollView(
                  key: ValueKey(value.categoryState.activeCategoryId),
                  slivers: [
                    // 按照栏目分类的产品列表 每个分类使用一个 SliverStickyHeader
                    ...value.productState.productList.map(
                      (e) => buildProductList(e),
                    ),
                    // 列表最后提示（没有更多数据了）
                    listEndTips,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget loadData({required Widget child}) {
    var state = controller.productState;
    if (state.loadDataWait) {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Colors.grey,
        ),
      );
    }

    if (state.loadDataEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/common/empty.png',
            width: 100,
            height: 100,
          ),
          SizedBox(height: 16),
          Text('暂无数据', style: TextStyle(color: Colors.grey)),
        ],
      );
    } else {
      return child;
    }
  }

  ///渲染单个项目
  Widget buildProducItem(ProductEntity item, {bool showAction = true}) {
    double _width = showAction ? 50 : 80;

    bool hasImage = item.image != null && File(item.image!).existsSync();
    final productPicture = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: hasImage
          ? Image.file(File(item.image!),
              width: _width, height: _width, fit: BoxFit.cover)
          : Image.asset('assets/images/nopic.png', width: _width),
    );
    final productInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // '我的商品库存title我的商品库存title我的商品库存',
          item.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                // '成本 ￥888',
                '成本 ￥${item.costPrice.toString()}',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                // '库存 99999',
                '库存 ${item.totalStock.toString()}',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ]),
            showAction
                ? InkWell(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.more_vert, size: 18),
                    ),
                    onTap: () => popupBottomSheet(item),
                  )
                : SizedBox()
          ],
        )
      ],
    );

    return Row(
      children: [
        productPicture,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: productInfo,
          ),
        ),
      ],
    );
  }

  /// 渲染项目列表
  Widget buildProductList(ProductListEntity sliver) {
    var categoryState = controller.categoryState;
    /**
    <ProductListEntity>[
      {
        categoryId: 1,
        productList: <ProductEntity>[],
      },
      {
        categoryId: 1,
        productList: <ProductEntity>[],
      },
    ]
     */
    final headerTitle = sliver.categoryId == 0
        ? '搜索'
        : categoryState.getCategoryNameById(sliver.categoryId);

    return SliverStickyHeader(
      header: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            )
          ],
        ),
        child: Center(
          child: Text(
            headerTitle,
            style: TextStyle(
              color: MyColors.primaryColor,
            ),
          ),
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            var product = sliver.productList[index];
            var isLast = product == sliver.productList.last;
            return Column(
              children: [
                buildProducItem(product),
                isLast
                    ? SizedBox(height: 16)
                    : Divider(indent: 16, endIndent: 16),
              ],
            );
          },
          childCount: sliver.productList.length,
        ),
      ),
    );
  }

  // 产品管理弹窗
  Future popupBottomSheet(ProductEntity element) {
    final productOverview = Container(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: buildProducItem(element, showAction: false),
    );

    final actionListBar = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () => Get.off(() => EditProductView(id: element.id)),
            title: Center(
              child: Text('编辑信息'),
            ),
          ),
          ListTile(
            onTap: () => controller.productState.handleDelete(element.id!),
            title: Center(
              child: Text('删除产品', style: TextStyle(color: Colors.red)),
            ),
          ),
          ListTile(
            onTap: () => Get.back(),
            title: Center(
              child: Text('取消', style: TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );

    return Get.bottomSheet(
      Wrap(children: [productOverview, actionListBar]),
      isScrollControlled: true,
    );
  }
}
