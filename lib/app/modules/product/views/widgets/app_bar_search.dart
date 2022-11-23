import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/product/controllers/product_controller.dart';
import 'package:shopkeeper/widgets/index.dart';

class AppBarSearch extends StatelessWidget {
  AppBarSearch({Key? key}) : super(key: key);

  final controller = TextEditingController();
  final keywords = ''.obs;
  final isFoucs = false.obs;

  onCcancel() {
    FocusManager.instance.primaryFocus?.unfocus();
    isFoucs.value = false;
    controller.clear();
    keywords.value = '';

    // 取消搜索时显示原来的数据
    var state = Get.find<ProductController>();
    state.categoryState.setActiveCategory(state.categoryState.activeCategoryId);
    state.showSearchView = false;
  }

  onSubmitted(value) async {
    var state = Get.find<ProductController>();
    state.showSearchView = true;
    state.productState.searchData(value);
  }

  @override
  Widget build(BuildContext context) {
    final cancelButton = IconButton(
      key: ValueKey('cancel'),
      // 点击取消
      onPressed: () => onCcancel(),
      icon: Icon(Icons.cancel, size: 18, color: Colors.red.shade400),
    );
    final scanButton = IconButton(
      icon: Image.asset('assets/images/common/qr-scan-2-line.png'),
      onPressed: () async {
        var result = await Get.to(() => QrScanView());
        if (result == null || result == '') {
          return;
        }
        isFoucs.value = true;
        onSubmitted('10');
      },
    );

    return Focus(
      onFocusChange: (e) => isFoucs.value = e,
      child: Obx(() {
        bool showCancel = isFoucs.value || keywords.value.isNotEmpty;
        return Container(
          height: 35,
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            onChanged: (value) => keywords.value = value,
            onSubmitted: (value) => onSubmitted(value), // 点击搜索按钮
            decoration: InputDecoration(
              filled: true,
              fillColor: showCancel ? Colors.white : Colors.grey.shade300,
              contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              hintText: '搜索内容',
              hintStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              prefixIcon: Icon(Icons.search, size: 20),
              suffixIcon: AnimatedSwitcher(
                duration: Duration(milliseconds: 150),
                child: showCancel ? cancelButton : scanButton,
              ),
            ),
          ),
        );
      }),
    );
  }
}
