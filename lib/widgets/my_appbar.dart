import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopkeeper/common/style/colors.dart';

Widget useActionButton({String? title, Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: TextButton(
      onPressed: onTap,
      child: Text(
        title ?? 'done'.tr,
        style: TextStyle(
          color: MyColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    this.title,
    this.leading,
    this.backgroundColor,
    this.actions,
    this.elevation,
    this.onAction,
    this.actionText,
    this.centerTitle = true,
    this.leadingWidth,
  }) : super(key: key);

  final String? title;
  final Widget? leading;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final double? elevation;
  final Function()? onAction;
  final String? actionText;
  final bool? centerTitle;
  final double? leadingWidth;

  static Widget useActionButton({String? title, Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title ?? 'done'.tr,
          style: TextStyle(
            color: MyColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation ?? 0,
      title: Text(
        title ?? '',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
      leadingWidth: leadingWidth,
      leading: leading,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xFF000000),
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
