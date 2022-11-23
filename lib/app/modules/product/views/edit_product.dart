import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/product/controllers/product_controller.dart';
import 'package:shopkeeper/common/style/colors.dart';
import 'package:shopkeeper/widgets/index.dart';

class EditProductView extends StatelessWidget {
  /// 产品id
  final int? id;
  final controller = Get.find<ProductController>();

  EditProductView({
    Key? key,
    this.id,
  }) : super(key: key);

  /// 自定义分组标题
  Widget buildGroupTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildPicturePicker() {
    var addState = controller.addProductState;
    return Center(
      child: MyImagePicker(
        key: ValueKey(addState.image),
        url: addState.image,
        onPicker: (e) {
          addState.product.value.image = e;
        },
        onRemove: (_) {
          addState.product.value.image = '';
        },
      ),
    );
  }

  Widget buildColorPicker() {
    var addState = controller.addProductState;
    //颜色列表
    List<String> colorList = [
      '666666',
      '5EB543',
      '5ECD8C',
      '5383EC',
      'B777F7',
      '7A65F3',
      '5DCCD1',
      'C22817',
      'E25C33',
      'EF8E80',
      'EDC14B',
      'EEEEEE',
    ];

    final child = Container(
      width: 80,
      height: 32,
      decoration: BoxDecoration(
        color: addState.color.isEmpty
            ? Colors.grey.shade200
            : Color(int.parse("0xFF${addState.color}")),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(child: Text('颜色')),
    );

    Widget buildColorItem(color) {
      return InkWell(
        onTap: () {
          addState.product.value.color = color;
          addState.product.refresh();
          Get.back();
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Color(int.parse("0xFF$color")),
            borderRadius: BorderRadius.circular(50),
          ),
          child: addState.color == color
              ? Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 26,
                )
              : SizedBox(),
        ),
      );
    }

    return Center(
      child: InkWell(
        child: child,
        onTap: () => buildGetxBottomSheet(
          height: 300,
          titleCenter: true,
          title: Text(
            '选择颜色',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Wrap(
                spacing: 32, // 主轴(水平)方向间距
                runSpacing: 16, // 纵轴（垂直）方向间距
                alignment: WrapAlignment.center, //沿主轴方向居中
                children: [
                  ...colorList.map((e) => buildColorItem(e)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBaseInfo() {
    var categoryState = controller.categoryState;
    var addState = controller.addProductState;

    final selectCategory = Column(
      children: [
        ...categoryState.categoryList.map((element) {
          bool _isActive = addState.categoryId == element.id;
          Widget title = Row(
            children: [
              Text(element.name,
                  style: TextStyle(color: _isActive ? Colors.blue : null)),
              SizedBox(width: 8),
              _isActive
                  ? Icon(Icons.check, color: Colors.blue, size: 18)
                  : SizedBox(),
            ],
          );
          return ListTile(
            onTap: () {
              addState.setCategory(element.id!);
              Get.back();
            },
            dense: true,
            title: title,
          );
        }),
      ],
    );

    return ListTileGroup(
      customerTitle: buildGroupTitle('基本信息'),
      children: [
        TextFieldItem(
          title: '产品名称',
          controller: addState.titleController,
          focusNode: addState.titleFocusNode,
          onChanged: (e) {
            addState.product.value.title = e;
          },
        ),
        Row(
          children: [
            Expanded(
              child: TextFieldItem(
                controller: addState.barcodeController,
                title: '产品条码',
                onChanged: (e) {
                  addState.product.value.barcode = e;
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.qr_code),
              onPressed: () async {
                //跳转扫描页之前先清除一下输入框焦点
                FocusManager.instance.primaryFocus?.unfocus();

                var result = await Get.to(() => QrScanView());
                if (result != null && result != '') {
                  addState.barcodeController.clear();
                  addState.barcodeController.text = result;
                }
              },
            ),
            SizedBox(width: 8),
          ],
        ),
        ClickTileItem(
          title: '所属分类',
          content: addState.categoryName,
          onTap: () {
            // 解除焦点
            FocusManager.instance.primaryFocus?.unfocus();
            buildGetxBottomSheet(
              height: 350,
              title: Text('选择分类'),
              body: selectCategory,
            );
          },
        ),
      ],
    );
  }

  Widget buildPriceInfo() {
    var addState = controller.addProductState;

    return ListTileGroup(
      customerTitle: buildGroupTitle('价格信息'),
      children: [
        TextFieldItem(
          title: '出售价格',
          controller: addState.salePriceController,
          keyboardType: TextInputType.number,
          onChanged: (e) {
            addState.product.value.salePrice =
                double.parse(e.isEmpty ? '0' : e);
          },
        ),
        TextFieldItem(
          title: '成本价格',
          controller: addState.costPriceController,
          keyboardType: TextInputType.number,
          onChanged: (e) {
            addState.product.value.costPrice =
                double.parse(e.isEmpty ? '0' : e);
          },
        ),
        Row(
          children: [
            Expanded(
              child: TextFieldItem(
                title: '库存数量',
                keyboardType: TextInputType.number,
                enabled: !addState.isInfinity,
                hintText: addState.isInfinity ? '无限库存' : '',
                controller: addState.totalStockController,
                onChanged: (e) {
                  addState.product.value.totalStock =
                      int.parse(e.isEmpty ? '0' : e);
                },
              ),
            ),
            Switch(
              value: addState.isInfinity,
              onChanged: (value) {
                addState.totalStockController.clear();
                addState.product.value.isInfinity = value ? 1 : 0;
                addState.product.refresh();
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildMoreInfo() {
    var addState = controller.addProductState;

    return ListTileGroup(customerTitle: buildGroupTitle('价格信息'), children: [
      SwitchListTile(
        title: Text('详细描述'),
        dense: false,
        value: addState.description.isNotEmpty,
        onChanged: (value) async {
          if (!value && addState.description.isEmpty) {
            addState.product.value.description = '';
            addState.product.refresh();
            return;
          }
          var result = await Get.to(
            () => DescView(
              data: addState.description,
            ),
          );
          if (result != null) {
            addState.product.value.description = result;
            addState.product.refresh();
          }
        },
      ),
      SwitchListTile(
        title: Text('属性规格'),
        dense: false,
        value: addState.attribute.isNotEmpty,
        onChanged: (value) async {
          if (!value && addState.attribute.isEmpty) {
            addState.product.value.attribute = '';
            addState.product.refresh();
            return;
          }
          var result = await Get.to(() => AttrView(
                data: addState.attribute,
              ));
          if (result != null) {
            String _json = '';
            if (result.length > 0) {
              _json = json.encode(result);
            }
            addState.product.value.attribute = _json;
            addState.product.refresh();
          }
        },
      ),
      SwitchListTile(
        title: Text('线上销售'),
        dense: false,
        value: addState.saleOnline,
        onChanged: (value) {
          addState.product.value.saleOnline = value ? 1 : 0;
          addState.product.refresh();
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    String pageTitle = id == null ? '添加产品' : '编辑产品';

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(
          title: pageTitle,
          actions: [
            MyAppBar.useActionButton(
              onTap: () => controller.addProductState.handleAdd(id),
            ),
          ],
        ),
        body: GetX<ProductController>(
          init: controller,
          // 初始化数据
          initState: (_) => controller.addProductState.initData(id),
          builder: (value) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildPicturePicker(),
                SizedBox(height: 8),
                buildColorPicker(),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: buildBaseInfo(),
                ),
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: buildPriceInfo(),
                ),
                SizedBox(height: 32),
                buildMoreInfo(),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: MyButton(
                    backgroundColor: MyColors.primaryColor,
                    onPressed: () => controller.addProductState.handleAdd(id),
                    text: '确定',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//属性规格
class AttrView extends StatelessWidget {
  final String? data;
  const AttrView({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arrtList = <Widget>[].obs;
    final textControllerList = <List<TextEditingController>>[].obs;
    buildTextField(title, index, subIndex) {
      return TextField(
        controller: textControllerList[index][subIndex],
        keyboardType: subIndex == 0 ? TextInputType.text : TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '请输入$title',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
        ),
      );
    }

    Widget buildAttrItem(index) {
      ValueKey<String> _key = ValueKey(index.toString());
      return Column(
        key: _key,
        children: [
          Container(
            height: 16,
            color: Color(0XFFF8F8F8),
          ),
          ListTile(
            dense: true,
            minVerticalPadding: 0,
            leading: Text('名称'),
            title: buildTextField('名称', index, 0),
            trailing: IconButton(
              icon: Text(
                '删除',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                showCupertinoDialog(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Text('确定删除该项吗'),
                      // content: Text('这将会清空数据并重置至初始状态'),
                      actions: [
                        CupertinoDialogAction(
                          child: Text(
                            'cancel'.tr,
                            style: TextStyle(color: Colors.black54),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        CupertinoDialogAction(
                          child: Text('confirm'.tr),
                          onPressed: () async {
                            for (var i = 0; i < arrtList.length; i++) {
                              if (arrtList[i].key == _key) {
                                arrtList.removeAt(i);
                                textControllerList.removeAt(i);
                                break;
                              }
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  dense: true,
                  minVerticalPadding: 0,
                  leading: Text('价格'),
                  title: buildTextField('价格', index, 1),
                ),
              ),
              Expanded(
                child: ListTile(
                  dense: true,
                  minVerticalPadding: 0,
                  leading: Text('成本'),
                  title: buildTextField('成本', index, 2),
                ),
              ),
            ],
          ),
          // Divider(),
        ],
      );
    }

    void addTextEditingController({Map<String, dynamic>? data}) {
      textControllerList.add([
        TextEditingController(text: data?['title'] ?? ''),
        TextEditingController(text: data?['salePrice'] ?? ''),
        TextEditingController(text: data?['costPrice'] ?? ''),
      ]);
      arrtList.add(buildAttrItem(arrtList.length));
    }

    /// 将json字符串还原成map
    if (data != null && data != '') {
      var _maps = json.decode(data!);
      for (var item in _maps) {
        addTextEditingController(data: item);
      }
    } else {
      addTextEditingController();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '属性规格',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          appBarDoneButton('保存', onTap: () {
            var mapList = [];
            for (var items in textControllerList) {
              var keyList = ['title', 'salePrice', 'costPrice'];
              int emptyLength = 3;
              var maps = {};
              for (var i = 0; i < items.length; i++) {
                var item = items[i];
                if (item.text.isEmpty) {
                  emptyLength--;
                  continue;
                }
                maps.addAll({keyList[i]: item.text});
              }
              if (emptyLength == 3) {
                mapList.add(maps);
              }
            }
            Get.back(result: mapList);
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              ...arrtList.map((item) => item),
              Container(
                height: 16,
                color: Color(0XFFF8F8F8),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () => addTextEditingController(),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                    EdgeInsets.symmetric(horizontal: 16),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.grey.shade200,
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.blue,
                  ),
                ),
                child: Text('继续添加规格'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 产品描述
class DescView extends StatelessWidget {
  final String? data;
  DescView({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = data ?? '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '描述信息',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          appBarDoneButton('保存', onTap: () {
            Get.back(result: controller.text);
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              maxLength: 100,
              maxLines: 5,
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '输入描述信息',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
