import 'package:flutter/material.dart';

class ClickTileItem extends StatelessWidget {
  const ClickTileItem({
    Key? key,
    required this.title,
    this.content = '',
    this.onTap,
    this.arrow,
    this.textAlign = TextAlign.right,
    this.contentStyle,
    this.customer,
  }) : super(key: key);

  final String title;
  final String? content;
  final Widget? arrow;
  final TextStyle? contentStyle;
  final GestureTapCallback? onTap;
  final TextAlign textAlign;
  final Widget? customer;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      children: [
        Text(title),
        SizedBox(width: 16),
        Expanded(
          child: customer ??
              Text(
                content!,
                textAlign: textAlign,
                overflow: TextOverflow.ellipsis,
                style: contentStyle ?? TextStyle(fontSize: 14),
              ),
        ),
        Visibility(
          visible: onTap != null,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: arrow ??
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
          ),
        )
      ],
    );
    final wrap = Container(
      constraints: const BoxConstraints(
        minHeight: 50.0,
      ),
      width: double.infinity,
      margin: const EdgeInsets.only(left: 16.0),
      child: child,
    );
    return InkWell(
      onTap: onTap,
      child: wrap,
    );
  }
}
