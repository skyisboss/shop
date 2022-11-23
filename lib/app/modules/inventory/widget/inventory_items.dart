import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/common/style/colors.dart';
// import 'package:shopkeeper/common/widgets/my_button_sheet.dart';

// 弹出层 - 选择操作项目
Widget buildActionSheet() {
  final _actions = [
    {
      'label': Text('修改库存'),
      'click': () {
        Get.back();
        Get.bottomSheet(
          buildPopupEdit2(),
          isScrollControlled: true,
        );
      }
    },
    {'label': Text('编辑产品'), 'click': () => Get.back()},
    {
      'label': Text('删除产品', style: TextStyle(color: Colors.red)),
      'click': () => Get.back()
    },
    {
      'label': Text('取消', style: TextStyle(color: Colors.grey)),
      'click': () => Get.back()
    },
  ];
  return Container(
    height: 205,
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
    child: Column(
      children: List.generate(
        _actions.length,
        (index) => Column(
          children: [
            ListTile(
              dense: true,
              onTap: _actions[index]['click'] as Function(),
              title: Center(child: _actions[index]['label'] as Widget),
            ),
            index == _actions.length - 2
                ? Container(
                    color: Colors.grey.shade600,
                    height: 10,
                  )
                : (index == _actions.length - 1)
                    ? SizedBox()
                    : Container(
                        color: Colors.grey.shade100,
                        height: 1,
                      ),
          ],
        ),
      ),
    ),
  );
}

Widget buildPopupEdit2() {
  _buildButton() {
    return Padding(
      padding: const EdgeInsets.all(0),
      // padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('取消'),
          ),
          SizedBox(width: 32),
          ElevatedButton(
            onPressed: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text('确定'),
            ),
          ),
        ],
      ),
    );
  }

  _buildAddStock() {
    final selectedRadio = 1.obs;
    return Column(
      children: [
        RadioListTile(
          value: 1,
          dense: true,
          contentPadding: EdgeInsets.all(0),
          groupValue: selectedRadio.value,
          onChanged: (value) => selectedRadio.value = 1,
          title: Text('库存调整'),
        ),
        RadioListTile(
          value: 4,
          dense: true,
          contentPadding: EdgeInsets.all(0),
          groupValue: selectedRadio.value,
          onChanged: (value) => selectedRadio.value = 4,
          title: Text('其他'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: '请输入成本',
                  label: Text('成本价格'),
                  border: InputBorder.none,
                ),
              ),
              Divider(thickness: 0.5, height: 1),
              TextField(
                decoration: InputDecoration(
                  hintText: '请输入数量',
                  label: Text('添加数量'),
                  border: InputBorder.none,
                ),
              ),
              Divider(thickness: 0.5, height: 1),
            ],
          ),
        ),
        Expanded(child: SizedBox()),
        _buildButton(),
      ],
    );
  }

  _buildDeductStock() {
    final selectedRadio = 1.obs;
    return Obx(() => Column(
          children: [
            RadioListTile(
              value: 1,
              dense: true,
              contentPadding: EdgeInsets.all(0),
              groupValue: selectedRadio.value,
              onChanged: (value) => selectedRadio.value = 1,
              title: Text('库存调整'),
            ),
            RadioListTile(
              value: 2,
              dense: true,
              contentPadding: EdgeInsets.all(0),
              groupValue: selectedRadio.value,
              onChanged: (value) => selectedRadio.value = 2,
              title: Text('货品损坏'),
            ),
            RadioListTile(
              value: 3,
              dense: true,
              contentPadding: EdgeInsets.all(0),
              groupValue: selectedRadio.value,
              onChanged: (value) => selectedRadio.value = 3,
              title: Text('货品丢失'),
            ),
            RadioListTile(
              value: 4,
              dense: true,
              contentPadding: EdgeInsets.all(0),
              groupValue: selectedRadio.value,
              onChanged: (value) => selectedRadio.value = 4,
              title: Text('其他'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '请输入数量',
                  label: Text('扣减数量'),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            _buildButton(),
          ],
        ));
  }

  return Container(
    padding: EdgeInsets.all(16),
    height: 500,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        )),
    child: DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.red, //MyColors.primaryColor,
              labelColor: Colors.red, //MyColors.primaryColor,
              unselectedLabelColor: Colors.black87,
              labelPadding: EdgeInsets.all(8),
              tabs: [
                Text('添加库存'),
                Text('扣减库存'),
              ],
            ),
          ),
          SizedBox(height: 16),
          buildItem(showAction: false),
          Expanded(
            child: TabBarView(children: [
              // 增加库存
              _buildAddStock(),
              // 减少库存
              _buildDeductStock(),
            ]),
          ),
        ],
      ),
    ),
  );
}

// 弹出层 - 修改库存信息
Widget buildPopupEdit() {
  return Text('data');
  /*
  return buildMyBottomSheet(
    // height: 600,
    // title: Text('修改库存', style: TextStyle(fontWeight: FontWeight.bold)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildItem(showAction: false),
          SizedBox(height: 16),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: TabBar(
                        tabs: [
                          Text('增加'),
                          Text('减少'),
                        ],
                        indicatorSize: TabBarIndicatorSize.label,
                        isScrollable: true,
                        indicatorColor: MyColors.primaryColor,
                        labelColor: MyColors.primaryColor,
                        unselectedLabelColor: Colors.black87,
                        labelPadding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 8)),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Text('data'),
                        Text('data'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 30,
            color: Colors.blue,
          )
        ],
      ),
    ),
  );
  */
}

Widget buildItem({bool showAction = true}) {
  return ListTile(
    leading: Icon(Icons.image, size: 40),
    contentPadding: EdgeInsets.all(0),
    title: Text(
      '我的商品库存title',
      style: TextStyle(fontSize: 14),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
    subtitle: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('成本=1000', style: TextStyle(fontSize: 12)),
              Text('库存x1000', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        InkWell(
          onTap: () => Get.bottomSheet(buildActionSheet()),
          child: Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(6),
            // color: Colors.red,
            child: Icon(Icons.more_vert, size: 18),
          ),
        )
      ],
    ),
  );
}

Widget buildItemListTile({bool showAction = true}) {
  return ListTile(
    leading: Image.asset('assets/images/nopic.png', width: 60.0),
    contentPadding: EdgeInsets.only(left: 16, right: 10),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '我的商品库存title我的商品库存title我的商品库存',
          style: TextStyle(fontSize: 14),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Column(
              children: [
                Text('成本: 1000',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text('库存: 1000',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            Expanded(child: SizedBox()),
            showAction
                ? InkWell(
                    onTap: () => Get.bottomSheet(buildActionSheet()),
                    child: Container(
                      // color: Colors.red,
                      padding: EdgeInsets.all(6),
                      margin: EdgeInsets.only(top: 4),
                      child: Icon(Icons.more_vert,
                          size: 18, color: MyColors.primaryColor),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ],
    ),
  );
}

/// 右侧列表
Widget buildItems() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        bottomLeft: Radius.circular(8),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: 20,
            itemBuilder: (context, index) => Column(
              children: [
                buildItemListTile(),
                Divider(
                  indent: 16,
                  endIndent: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
