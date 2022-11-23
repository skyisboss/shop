import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:shopkeeper/common/widgets/getx_button_sheet.dart';
import '../controllers/inventory_controller.dart';

class AddProductView extends GetView<InventoryController> {
  buildLabelText(
    String title, {
    Color? color,
    double? fontSize = 20,
    FontWeight? fontWeight = FontWeight.normal,
  }) =>
      Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      );

  buildDialog() {
    Get.defaultDialog<Widget>(
      title: '',
      radius: 10,
      titlePadding: EdgeInsets.all(0),
      content: Container(
          height: 300,
          width: double.maxFinite,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('data'),
              )
            ],
          )),
    );
  }

  Widget buildBodyContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 10),
          //   child: buildLabelText('基本信息', fontWeight: FontWeight.bold),
          // ),
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    // 产品图片
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.add_a_photo,
                          size: 44,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    // 移除图片按钮
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        color: Colors.red,
                        icon: Icon(Icons.remove_circle),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: InkWell(
                    // onTap: () => buildGetxBottomSheet(
                    //   height: 350,
                    //   title: buildLabelText('选择颜色', fontSize: 16),
                    //   body: Container(),
                    // ),
                    child: Center(
                      child: Text('颜色 (无)'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: buildLabelText('基本信息', fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: buildLabelText('产品名称', fontSize: 16),
                title: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              Divider(height: 0, thickness: 0.5),
            ],
          ),
          Column(
            children: [
              ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: buildLabelText('产品条码', fontSize: 16),
                  title: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.qr_code_scanner),
                  )),
              Divider(height: 0, thickness: 0.5),
            ],
          ),
          Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: buildLabelText('栏目分类', fontSize: 16),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    buildLabelText('请选择', fontSize: 14, color: Colors.grey),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                    ),
                  ],
                ),
                // onTap: () => buildGetxBottomSheet(
                //   height: 350,
                //   title: buildLabelText('选择颜色', fontSize: 16),
                //   body: Container(
                //     color: Color(0xfff8f8f8),
                //     child: Column(children: [
                //       ...List.generate(
                //         50,
                //         (index) => ListTile(
                //           title: Text('index'),
                //         ),
                //       )
                //     ]),
                //   ),
                // ),
              ),
              Divider(height: 0, thickness: 0.5),
            ],
          ),

          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: buildLabelText('价格信息', fontWeight: FontWeight.bold),
          ),

          Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: buildLabelText('出售价/￥', fontSize: 16),
                title: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              Divider(height: 0, thickness: 0.5),
            ],
          ),
          Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: buildLabelText('成本价/￥', fontSize: 16),
                title: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '输入成本价',
                    hintStyle: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              Divider(height: 0, thickness: 0.5),
            ],
          ),
          Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: buildLabelText('库存数量', fontSize: 16),
                title: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildLabelText('(无限库存)', fontSize: 12),
                    Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              Divider(height: 0, thickness: 0.5),
            ],
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: buildLabelText('产品属性', fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            value: false,
            contentPadding: EdgeInsets.all(0),
            onChanged: (value) => buildDialog(),
            title: Text('产品属性'),
          ),
          SwitchListTile(
            value: false,
            contentPadding: EdgeInsets.all(0),
            onChanged: (value) {},
            title: Text('产品规格'),
          ),
          SwitchListTile(
            value: false,
            contentPadding: EdgeInsets.all(0),
            onChanged: (value) {},
            title: Text('产品描述'),
          ),
          SwitchListTile(
            value: false,
            contentPadding: EdgeInsets.all(0),
            onChanged: (value) {},
            title: Text('线上销售'),
          ),
          // SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        // centerTitle: false,
        title: Text(
          '新增产品',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: buildBodyContent(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('保存'),
            ),
          ),
        ],
      ),
    );
  }
}
