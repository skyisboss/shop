import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/inventory/controllers/inventory_controller.dart';
import 'package:shopkeeper/app/modules/inventory/data/index.dart';
import 'package:shopkeeper/common/style/colors.dart';

var controller = Get.find<InventoryController>();

void _buildPopupDialog({CategoryEntity? item}) {
  TextEditingController _textController = TextEditingController();
  final isEdit = item == null ? false : true;
  final _title = isEdit ? '编辑分类' : '新增分类';
  _textController.text = isEdit ? item.name : '';

  showCupertinoDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(_title),
        content: Material(
          color: Colors.transparent,
          child: Container(
            height: 55,
            margin: EdgeInsets.only(top: 16),
            child: TextField(
              controller: _textController,
              maxLength: 30,
              decoration: InputDecoration(
                hintText: '输入分类名称',
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
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              'cancel'.tr,
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: Text('confirm'.tr),
            onPressed: () async {
              if (_textController.text.isEmpty) return;
              if (isEdit) {
                // 编辑栏目
                controller.categoryState
                    .edit(id: item.id!, name: _textController.text);
              } else {
                // 新增栏目
                controller.categoryState.add(_textController.text);
                // EasyLoading.show();
              }
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

Widget _buildCategoryItem(element) {
  /// 当前选中的栏目给予高亮线上
  final _decoration = controller.categoryState.activeCategoryId == element.id
      ? BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(color: MyColors.primaryColor, width: 3),
          ),
        )
      : BoxDecoration();

  // id=1的分类是【全部】，默认无法删除
  final _trailing = element.id == 1
      ? SizedBox()
      : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, size: 18),
              onPressed: () => _buildPopupDialog(item: element),
            ),
            // id=1的分类是【全部】，默认无法删除
            IconButton(
              icon: Icon(Icons.delete, size: 18),
              onPressed: () {
                showCupertinoDialog(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Text('确定删除该分类吗'),
                      // content: Text('这将会清空数据并重置至初始状态'),
                      actions: [
                        CupertinoDialogAction(
                          child: Text(
                            'cancel'.tr,
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        CupertinoDialogAction(
                          child: Text('confirm'.tr),
                          onPressed: () async {
                            controller.categoryState.delete(element.id);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
  return AnimatedContainer(
    duration: Duration(milliseconds: 200),
    decoration: _decoration,
    child: ListTile(
      dense: true,
      onTap: () {
        // 切换栏目时,设置选中高亮和刷新产品列表
        controller.categoryState.setActiveCategoryId(element.id);
        // if (controller.categoryState.activeCategoryId != element.id) {
        //   controller.categoryState.setActiveCategoryId(element.id);
        // }
      },
      contentPadding: EdgeInsets.only(left: 8, right: 6),
      title: Text(
        element.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 13),
      ),
      trailing: controller.siderExpand ? _trailing : null,
    ),
  );
}

Widget buildCategoryList() {
  return GetX<InventoryController>(
    init: controller,
    initState: (_) {},
    builder: (_) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...controller.categoryState.category.map(
                    (element) => _buildCategoryItem(element),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => controller.siderExpand = !controller.siderExpand,
              icon: controller.siderExpand
                  ? Icon(Icons.close, color: Colors.red)
                  : Icon(Icons.read_more),
            ),
            controller.siderExpand
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TextButton(
                      onPressed: () => _buildPopupDialog(),
                      child: Text('新增分类'),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ],
    ),
  );
}
