import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/product/data/export.dart';
import 'package:shopkeeper/common/values/index.dart';
import 'package:shopkeeper/widgets/index.dart';
import 'package:shopkeeper/widgets/popup_drop_down.dart';
import '../controllers/pos_controller.dart';
import 'cart_view.dart';

class PosView extends GetView<PosController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetX<PosController>(
        init: PosController(),
        initState: (_) {
          controller.posState.initData();
        },
        builder: (_) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: Color(0xfff2f2f2),
            body: Column(
              children: [
                Expanded(child: buildGoodsList()),
                buildButtomBar(),
              ],
            ),
          );
        },
      ),
    );
  }

  // 显示购买数量
  Widget buildSelectTotal(ProductEntity item, int existIndex) {
    int total = 0;
    bool active = existIndex >= 0;
    if (active) {
      total = controller.orderState.orderGoodsList[existIndex].total;
    }
    return active
        ? InkWell(
            onTap: () =>
                controller.orderState.removeOrder(id: item.id!, element: item),
            child: Container(
              decoration: MyStyle.boxDecoration,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                '$total',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        : SizedBox();
  }

  // 构建商品视图
  Widget buildGoodsItem(ProductEntity element, int index, int existIndex) {
    var active = existIndex >= 0;
    final goodsImage = Image.asset(
      'assets/images/nopic.png',
      fit: BoxFit.cover,
    );

    if (controller.gridLayout) {
      final goodsInfo = Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: controller.gridLayout
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Text(
              element.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 12),
            ),
            Text(
              element.salePrice.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      );
      return InkWell(
        onTap: () {
          controller.orderState.addOrder(id: element.id!, element: element);
        },
        child: Container(
          decoration: BoxDecoration(
            color: active ? Colors.blue.shade100 : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4)),
            // border: Border.all(color: Colors.blue.shade100),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(flex: 2, child: Center(child: goodsImage)),
                  Expanded(flex: 1, child: goodsInfo),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: buildSelectTotal(element, existIndex),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      final goodsInfo = Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  element.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Spacer(),
                Text(
                  element.salePrice.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          buildSelectTotal(element, existIndex),
        ],
      );

      return InkWell(
        onTap: () {
          controller.orderState.addOrder(id: element.id!, element: element);
        },
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              goodsImage,
              SizedBox(width: 16),
              Expanded(child: goodsInfo),
            ],
          ),
        ),
      );
    }
  }

  // 过滤项
  Widget _buildFilterItem(String title) {
    return TextButton(
      onPressed: () {},
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.black87),
        child: Row(
          children: [
            Text(title),
            Icon(Icons.unfold_more, size: 14, color: Colors.black87),
          ],
        ),
      ),
    );
  }

  Widget buildGoodsList() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: 0.6,
          title: Column(
            children: [
              Divider(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildFilterItem('价格'),
                  _buildFilterItem('销量'),
                  _buildFilterItem('时间'),

                  // 切换视图按钮
                  IconButton(
                    onPressed: () {
                      controller.gridLayout = !controller.gridLayout;
                    },
                    icon: Icon(
                      controller.gridLayout
                          ? Icons.ballot_outlined
                          : Icons.grid_view,
                      size: 20,
                    ),
                  )
                ],
              ),
            ],
          ),
          leadingWidth: 0,
          floating: true,
          snap: true,
          leading: SizedBox(),
          backgroundColor: Colors.white,
        ),
        SliverPadding(
          padding: controller.gridLayout
              ? EdgeInsets.all(8)
              : EdgeInsets.symmetric(vertical: 8),
          sliver: SliverGrid(
            gridDelegate: controller.gridLayout
                ? SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: .8,
                  )
                : SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 8,
                    childAspectRatio: 4.5,
                  ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var element = controller.posState.productList[index];
                var orderState = controller.orderState;
                int exist = orderState.existOrder(element.id!);
                return buildGoodsItem(element, index, exist);
              },
              childCount: controller.posState.productList.length,
              // items.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtomBar() {
    var orderState = controller.orderState;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      width: double.infinity,
      height: 57,
      child: Row(
        children: [
          //选购信息
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: 32,
                  color: orderState.orderItemTotal > 0
                      ? Colors.deepOrange
                      : Colors.grey.shade400,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('共 ${orderState.orderItemTotal} 件'),
                    Text('合计 ￥${orderState.orderPriceTotal}',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          //结算按钮
          ElevatedButton(
            onPressed: () {
              Get.to(() => CartView());
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
              ),
            ),
            child: Row(
              children: [
                Text('购物车'),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(context) {
    final appbarTitle = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(controller.posState.currCategoryText(),
            style: TextStyle(color: Colors.black87)),
        Icon(Icons.arrow_drop_down),
      ],
    );
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: BackButton(
        onPressed: () {
          if (controller.orderState.orderItemTotal > 0) {
            cupertinoDialog(
              Get.context!,
              title: Text('提示'),
              content: Text('返回将清空购物车信息'),
              onConfirm: () {
                Get.back();
              },
            );
          } else {
            Get.back();
          }
        },
      ),
      title: controller.isShowSearch
          ? AppBarSearch(
              inputColor: Colors.grey.shade100,
            )
          : InkWell(
              child: appbarTitle,
              onTap: () {
                EasyPopup.show(
                  context,
                  PopupDropdown(child: PopupCategoryView()),
                  offsetLT: Offset(0, MediaQuery.of(context).padding.top + 60),
                );
              },
            ),
      actions: [
        controller.isShowSearch
            ? TextButton(
                onPressed: () {
                  controller.isShowSearch = !controller.isShowSearch;
                },
                child: Text('取消'),
              )
            : Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.qr_code_scanner, size: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.isShowSearch = !controller.isShowSearch;
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
      ],
    );
  }
}

class PopupCategoryView extends StatelessWidget {
  const PopupCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var posState = Get.find<PosController>().posState;

    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 300,
        width: double.maxFinite,
        color: Colors.white,
        child: Obx(() => SingleChildScrollView(
              child: Column(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: posState.categoryList.map((element) {
                    int currId = posState.currCategoryId;
                    bool active = currId == element.id;
                    return ListTile(
                      onTap: () {
                        posState.currCategoryId = element.id;
                      },
                      title: Text(
                        element.name,
                        style: active
                            ? TextStyle(color: Colors.blue)
                            : TextStyle(),
                      ),
                      trailing: active
                          ? Icon(Icons.check, color: Colors.blue)
                          : SizedBox(),
                    );
                  }),
                ).toList(),
              ),
            )),
      ),
    );
  }
}
