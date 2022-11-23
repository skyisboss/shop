import 'package:flutter/material.dart';

class EmptyStatus extends StatelessWidget {
  const EmptyStatus({
    Key? key,
    this.label,
    this.labelColor,
    this.content,
    this.icon,
  }) : super(key: key);

  final String? label;
  final Color? labelColor;
  final Widget? content;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon ??
            Image.asset(
              'assets/images/common/empty.png',
              width: 100,
              height: 100,
            ),
        SizedBox(height: 16),
        content ??
            Text(
              label ?? '暂无数据',
              style: TextStyle(color: labelColor ?? Colors.grey),
            ),
      ],
    );
  }
}
