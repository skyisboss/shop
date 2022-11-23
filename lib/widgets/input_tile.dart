import 'package:flutter/material.dart';

/// ListTile 类型的 输入框
class InputTile extends StatelessWidget {
  final Widget? label;
  final Widget? trailing;
  final Widget? child;
  final double? height;
  final String? hintText;
  final TextStyle? hintStyle;
  final InputBorder border;
  final int maxLines;
  final bool isDivider;
  final bool arrow;

  /// ListTile 类型的 输入框
  InputTile({
    Key? key,
    this.label,
    this.height,
    this.hintText,
    this.hintStyle,
    this.trailing,
    this.border = InputBorder.none,
    this.maxLines = 1,
    this.isDivider = true,
    this.arrow = true,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height ?? 48,
          child: ListTile(
            dense: true,
            visualDensity: VisualDensity(vertical: 0),
            leading: label,
            title: child ??
                TextField(
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    isDense: true,
                    hintText: hintText,
                    hintStyle: hintStyle ??
                        TextStyle(fontSize: 14, color: Colors.grey),
                    border: border,
                  ),
                ),
            trailing: arrow ? Icon(Icons.keyboard_arrow_right) : trailing,
          ),
        ),
        isDivider ? Divider(height: 1) : SizedBox(),
      ],
    );
  }
}
