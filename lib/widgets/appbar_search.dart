import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarSearch extends StatelessWidget {
  AppBarSearch({
    Key? key,
    this.textController,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.onFoucs,
    this.onCcancel,
    this.onChanged,
    this.onSubmitted,
    this.inputColor,
  }) : super(key: key);

  final TextEditingController? textController;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final Function(bool)? onFoucs;
  final Function()? onCcancel;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Color? inputColor;

  final keywords = ''.obs;
  final isFoucs = false.obs;
  final _textController = TextEditingController();

  _onCcancel() {
    FocusManager.instance.primaryFocus?.unfocus();
    _textController.clear();
    isFoucs.value = false;
    keywords.value = '';

    // 取消搜索时显示原来的数据
    // var state = Get.find<ProductController>();
    // state.categoryState.setActiveCategory(state.categoryState.activeCategoryId);
    // state.showSearchView = false;
  }

  _onSubmitted(value) async {
    // var state = Get.find<ProductController>();
    // state.showSearchView = true;
    // state.productState.searchData(value);
  }

  @override
  Widget build(BuildContext context) {
    final cancelButton = IconButton(
      key: ValueKey('cancel'),
      // 点击取消
      onPressed: () => onCcancel ?? _onCcancel(),
      icon: Icon(Icons.cancel, size: 18, color: Colors.red.shade400),
    );

    return Focus(
      onFocusChange: (e) {
        isFoucs.value = e;
        if (onFoucs != null) {
          onFoucs!(e);
        }
      },
      child: Obx(() {
        bool showCancel = isFoucs.value || keywords.value.isNotEmpty;
        return Container(
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: textController ?? _textController,
            textInputAction: TextInputAction.search,
            onChanged: (value) => onChanged ?? (keywords.value = value),
            onSubmitted: (value) =>
                onSubmitted ?? _onSubmitted(value), // 点击搜索按钮
            decoration: InputDecoration(
              filled: true,
              fillColor: inputColor ?? Colors.white,
              // showCancel ? Colors.white : Colors.grey.shade300,
              contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              hintText: '搜索内容',
              hintStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              prefixIcon: prefixIcon ?? Icon(Icons.search, size: 20),
              suffixIcon: suffixIcon ??
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 150),
                    child: showCancel ? cancelButton : SizedBox(),
                  ),
            ),
          ),
        );
      }),
    );
  }
}
