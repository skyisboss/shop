import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import 'edit_product.dart';
import 'widgets/app_bar_search.dart';
import 'widgets/category_list.dart';
import 'widgets/product_list.dart';

class ProductView extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFF2F2F2),
          title: AppBarSearch(),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Get.to(() => EditProductView()),
            ),
          ],
        ),
        body: GetX<ProductController>(
          init: controller,
          initState: (_) {
            controller.showSearchView = false;
            controller.siderExpand = false;
          },
          builder: (value) => Row(
            children: [
              value.showSearchView ? SizedBox() : CategoryList(),
              value.siderExpand ? SizedBox() : ProductList(),
            ],
          ),
        ),
      ),
    );
  }
}
