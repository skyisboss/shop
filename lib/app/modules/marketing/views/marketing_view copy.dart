import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:shopkeeper/common/widgets/index.dart';

import '../controllers/marketing_controller.dart';

class MarketingView extends GetView<MarketingController> {
  buildListTile({
    required Widget title,
    Widget? subtitle,
    required Icon leading,
    Function()? onTap,
  }) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            dense: true,
            leading: leading,
            title: title,
            subtitle: subtitle ?? SizedBox(),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: onTap,
          ),
        ),
        Divider(height: 0.5),
      ],
    );
  }

  /// tab选项卡
  Widget buildTabItem(title, icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18),
        SizedBox(width: 5),
        Text(title),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          title: Text('营销'),
          centerTitle: true,
          leading: BackButton(color: Colors.white),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          ],
          bottom: TabBar(
            labelPadding: EdgeInsets.all(16),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.red,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            tabs: [
              buildTabItem('折扣', Icons.local_offer),
              // buildTabItem('优惠卷', Icons.emoji_emotions),
              // buildTabItem('优惠商品', Icons.shopping_basket),
            ],
          ),
        ),
        body: DefaultTabController(
          length: 1,
          // padding: EdgeInsets.symmetric(vertical: 16),
          child: TabBarView(children: [
            /*
            /// 折扣
            Expanded(
              child: Column(
                children: [
                  ...controller.discountList.map(
                    (item) => Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(Icons.local_offer),
                            title: Text(item['title'] as String),
                            subtitle: Text('有效期 ${item['expire'] as String}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('x ${item['total'] as String}'),
                                Icon(Icons.keyboard_arrow_right),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: 0, thickness: 0.5),
                      ],
                    ),
                  )
                ],
              ),
            ),

            /// 优惠劵
            Expanded(
              child: Column(
                children: [
                  ...controller.discountList.map(
                    (item) => Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(Icons.emoji_emotions),
                            title: Text(item['title'] as String),
                            subtitle: Text('有效期 ${item['expire'] as String}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('x ${item['total'] as String}'),
                                Icon(Icons.keyboard_arrow_right),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: 0, thickness: 0.5),
                      ],
                    ),
                  )
                ],
              ),
            ),
            */
            /// 优惠商品
            // Expanded(child: buildTabItem('优惠商品', Icons.shopping_basket)),
            Column(
              children: [
                ...List.generate(
                    50, (index) => buildTabItem('优惠商品', Icons.shopping_basket))
              ],
            )
          ]),
        ));
  }
}
