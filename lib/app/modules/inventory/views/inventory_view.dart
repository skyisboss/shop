import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/widgets/index.dart';
import '../controllers/inventory_controller.dart';
import '../widget/index.dart';
import 'add_product_view.dart';

// ignore: must_be_immutable
class InventoryView extends GetView<InventoryController> {
  InventoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetX<InventoryController>(
        init: controller,
        initState: (_) {},
        builder: (_) {
          _buildCategoryList() => Expanded(
                flex: 1,
                child: buildCategoryList(),
              );
          _buildContentList() => controller.siderExpand
              ? SizedBox()
              : Expanded(
                  flex: 3,
                  child: buildProductList(),
                );
          return Scaffold(
            backgroundColor: Color(0xFFF2F2F2),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0xFFF2F2F2),
              title: buildAppBarTitle(),
              leading: IconButton(
                onPressed: () {
                  controller.siderExpand
                      ? controller.siderExpand = false
                      : Get.back();
                },
                icon: Icon(Icons.arrow_back),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => EasyPopup.show(
                    context,
                    DropPopupMenu(actions: [
                      MenuItem(
                        title: '添加产品',
                        onTap: () => Get.off(() => AddProductView()),
                      ),
                      MenuItem(title: '扫码添加'),
                    ]),
                    offsetLT:
                        Offset(0, MediaQuery.of(context).padding.top + 50),
                  ),
                ),
              ],
            ),
            body: Row(
              children: [
                controller.isSearch.value ? SizedBox() : _buildCategoryList(),
                _buildContentList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
