import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

void cupertinoDialog(
  BuildContext context, {
  Widget? title,
  Widget? content,
  Function()? onCancel,
  Function()? onConfirm,
  String? cancenText,
  String? confirmText,
  Color? cancenColor,
  Color? confirmColor,
  List<Widget>? actions,
}) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: title,
        content: content,
        actions: actions ??
            [
              CupertinoDialogAction(
                child: Text(
                  cancenText ?? 'cancel'.tr,
                  style: TextStyle(
                    color: cancenColor ?? Colors.red,
                  ),
                ),
                onPressed: () {
                  if (onCancel != null) {
                    onCancel();
                  }
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text(confirmText ?? 'confirm'.tr),
                onPressed: () async {
                  if (onConfirm != null) {
                    onConfirm();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
      );
    },
  );
}
