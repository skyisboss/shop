import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/product/controllers/product_controller.dart';
import 'package:shopkeeper/app/modules/product/data/export.dart';
import 'package:shopkeeper/common/style/colors.dart';

class CategoryList extends StatelessWidget {
  CategoryList({Key? key}) : super(key: key);
  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return GetX<ProductController>(
      init: controller,
      initState: (_) {
        // 初始化数据
      },
      builder: (_) {
        return Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                child: buildCategoryList(),
              ),
              buildButtonBar(),
            ],
          ),
        );
      },
    );
  }

  /// 渲染菜单项
  Widget buildCategoryItem(CategoryEntity category) {
    //当前是否高亮
    final categoryActive =
        controller.categoryState.activeCategoryId == category.id;

    /// 当前选中的栏目给予高亮线上
    final _decoration = categoryActive
        ? BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(color: MyColors.primaryColor, width: 3),
            ),
          )
        : BoxDecoration();

    /// 右侧操作按钮
    final _rightButton = controller.siderExpand && category.id! != 1
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, size: 18),
                onPressed: () {
                  controller.categoryState.handleUpdate(category);
                },
              ),
              // id=1的分类是【全部】，默认无法删除
              IconButton(
                icon: Icon(Icons.delete, size: 18),
                onPressed: () {
                  controller.categoryState.handleDelete(category.id!);
                },
              ),
            ],
          )
        : null;

    final _titleStyle = categoryActive
        ? TextStyle(
            color: MyColors.primaryColor,
            fontWeight: FontWeight.bold,
          )
        : null;

    return AnimatedContainer(
      padding: EdgeInsets.only(left: 8),
      duration: Duration(milliseconds: 200),
      decoration: _decoration,
      child: Builder(builder: (context) {
        return ListTile(
            dense: true,
            title: Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: _titleStyle,
            ),
            contentPadding: EdgeInsets.all(0),
            trailing: _rightButton,
            // 点击切换栏目
            onTap: () {
              //如果是侧边是展开状态则不切换
              if (!controller.siderExpand) {
                controller.categoryState.setActiveCategory(category.id!);
              }
            });
      }),
    );
  }

  /// 菜单显示区域
  Widget buildCategoryList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          ...controller.categoryState.categoryList.map((e) {
            return buildCategoryItem(e);
          })
        ],
      ),
    );
  }

  /// 侧边菜单底部栏
  Widget buildButtonBar() {
    final expandButtonIcon = controller.siderExpand
        ? Icon(Icons.close, color: Colors.red, key: ValueKey('1'))
        : Icon(Icons.read_more, key: ValueKey('2'));
    final addButton = controller.siderExpand
        ? Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () => controller.categoryState.handleUpdate(null),
              child: Text('新增分类'),
            ),
          )
        : SizedBox();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: expandButtonIcon,
          ),
          onPressed: () {
            controller.handleSideToggle();
          },
        ),
        addButton,
      ],
    );
  }
}
