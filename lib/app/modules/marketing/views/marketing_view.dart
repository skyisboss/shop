import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shopkeeper/app/modules/marketing/data/export.dart';
import 'package:shopkeeper/widgets/index.dart';

import '../controllers/marketing_controller.dart';
import 'add_discount.dart';

class MarketingView extends GetView<MarketingController> {
  @override
  Widget build(BuildContext context) {
    /// 添加按钮
    final addActions = IconButton(
      icon: Icon(Icons.add, color: Colors.white),
      onPressed: () {
        EasyPopup.show(
          context,
          DropPopupMenu(actions: [
            MenuItem(
              title: '新增折扣',
              onTap: () => Get.off(() => AddDiscount(type: 0)),
            ),
            MenuItem(
              title: '新增优惠劵',
              onTap: () => Get.off(() => AddDiscount(type: 1)),
            ),
          ]),
          offsetLT: Offset(0, MediaQuery.of(context).padding.top + 50),
        );
      },
    );

    final tabbar = TabBar(
      labelPadding: EdgeInsets.all(12),
      indicatorColor: Colors.red,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelColor: Colors.grey.shade400,
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
      tabs: controller.listState.tabs.map((e) => Text(e)).toList(),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          title: Text('营销'),
          centerTitle: true,
          leading: BackButton(color: Colors.white),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          actions: [
            addActions,
          ],
          bottom: tabbar,
        ),
        body: Builder(builder: (context) {
          return GetX<MarketingController>(
            init: controller,
            initState: (_) {},
            builder: (_) => TabBarView(children: [
              ...controller.listState.listPageData.asMap().keys.map((index) {
                var listPageData = controller.listState.listPageData[index];
                Widget child = listPageData.isEmpty
                    ? Container(
                        color: Colors.white,
                        child: EmptyStatus(),
                      )
                    : ListView(
                        children: listPageData
                            .map(
                              (element) => buildPageItem(element),
                            )
                            .toList(),
                      );
                return buildPageView(
                  index: index,
                  context: context,
                  child: child,
                );
              }),
            ]),
          );
        }),
      ),
    );
  }

  /// 渲染列表项目
  Widget buildPageItem(DiscountEntity item) {
    IconData icon;
    Color color;
    if (item.type == 0) {
      icon = Icons.local_offer;
      color = Colors.blue.shade300;
    } else {
      icon = Icons.emoji_emotions;
      color = Colors.green.shade300;
    }
    return Column(
      children: [
        SizedBox(height: 16),
        Container(
          color: Colors.white,
          child: ListTile(
            onTap: () =>
                Get.to(() => AddDiscount(id: item.id, type: item.type)),
            leading: Icon(icon, size: 36, color: color),
            title: Text(item.title),
            subtitle: Text(
              '有效期 ${item.expiredDate}',
              style: TextStyle(color: Colors.red.shade400),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('x ${item.discountAmount}'),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 渲染列表页面
  Widget buildPageView({
    required Widget child,
    required BuildContext context,
    required int index,
  }) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(
        complete: Column(
          children: [
            SizedBox(height: 16),
            Icon(Icons.check_circle, color: Colors.green),
            Text(
              '刷新完成',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget child;
          switch (mode) {
            case LoadStatus.idle:
              child = Text("上拉加载");
              break;
            case LoadStatus.loading:
              child = CupertinoActivityIndicator();
              break;
            case LoadStatus.failed:
              child = Text("加载失败！点击重试！");
              break;
            case LoadStatus.canLoading:
              child = Text("松手,加载更多!");
              break;
            default:
              child = Text(
                "没有更多数据了",
                style: TextStyle(color: Colors.grey),
              );
          }
          return Container(
            height: 55.0,
            child: Center(child: child),
          );
        },
      ),
      controller: controller.listState.refreshController[index],
      onRefresh: () {
        var pageType = DefaultTabController.of(context)?.index;
        controller.listState.onRefresh(pageType ?? 0);
      },
      onLoading: () {
        var pageType = DefaultTabController.of(context)?.index;
        controller.listState.onLoading(pageType ?? 0);
      },
      child: child,
    );
  }
}

/// 折扣
              // SmartRefresher(
              //   enablePullDown: true,
              //   enablePullUp: true,
              //   controller: controller.refreshControllers[0],
              //   header: WaterDropHeader(),
              //   onRefresh: () => _onRefresh(0),
              //   onLoading: () => _onLoading(0),
              //   child: buildPageView(
              //     child: Column(
              //       children: [
              //         ...controller.discountList.map(
              //           (element) => buildPageItem(element, 'discount'),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
/// 优惠商品
                  /*
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        ...controller.discountGoods.map(
                          (item) => Column(
                            children: [
                              Container(
                                color: Colors.white,
                                child: ListTile(
                                  // dense: true,
                                  leading: Image.asset(
                                    'assets/images/nopic.png',
                                    width: 60,
                                  ),
                                  title: Text(
                                    item['title'] as String,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // SizedBox(height: 6),

                                      Text(
                                        '原价 ￥${item['old_price'] as String} ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Colors.grey.shade600,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '优惠价 ￥${item['new_price'] as String}',
                                            style: TextStyle(
                                              // fontSize: 14,
                                              color: Colors.red,
                                            ),
                                          ),
                                          Text(
                                            '有效期 ${item['expire'] as String}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  trailing: Icon(Icons.delete),
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  */