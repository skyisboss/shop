import 'package:flutter/material.dart';

/// 用于构建 ListTile 的cell列表

class ListTileGroup extends StatelessWidget {
  final String? title;
  final double? titleSize;
  final Color? titleColor;
  final Widget? customerTitle;
  final EdgeInsetsGeometry? padding;
  final bool showBorder;
  final List<Widget> children;

  ListTileGroup({
    Key? key,
    this.title,
    this.titleSize,
    this.titleColor,
    this.customerTitle,
    this.showBorder = true,
    required this.children,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customerTitle ??
            Padding(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                title ?? '',
                style: TextStyle(
                  color: titleColor ?? Colors.grey,
                  fontSize: titleSize ?? 12,
                ),
              ),
            ),
        showBorder ? Divider(height: 0.5) : SizedBox(),
        ...children.map((item) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item,
              item == children.last
                  ? SizedBox()
                  : Divider(height: 0.5, indent: 16, endIndent: 16)
              // : Container(
              //     height: 0.5,
              //     color: Colors.white,
              //     child: Divider(
              //       height: 0.5,
              //       indent: 16,
              //       endIndent: 16,
              //     ),
              //   ),
            ],
          );
        }),
        showBorder ? Divider(height: 0.5) : SizedBox(),
      ],
    );
  }
}

class ListTileItem extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? titleColor;
  final double? titleSize;
  final Color? subColor;
  final double? subSize;
  final Widget? leading;
  final Widget? trailing;
  final bool? arrow;
  final Widget? content;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;

  ListTileItem({
    Key? key,
    this.content,
    this.leading,
    this.onTap,
    this.subColor,
    this.subSize,
    this.subtitle,
    this.title,
    this.titleColor,
    this.titleSize,
    this.trailing,
    this.arrow,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? _mWidget;

    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        onTap: onTap,
        dense: true,
        leading: leading,
        title: content ??
            Text(
              title ?? '',
              style: TextStyle(
                fontSize: titleSize ?? 14,
                color: titleColor ?? Colors.black87,
              ),
            ),
        subtitle: subtitle == null
            ? _mWidget
            : Text(
                subtitle!,
                style: TextStyle(
                  fontSize: subSize ?? 12,
                  color: subColor ?? Colors.grey,
                ),
              ),
        trailing: content != null
            ? _mWidget
            : trailing ??
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Color(0xFFCCCCCC),
                ),
      ),
    );
  }
}

class ListTileItemContent extends StatelessWidget {
  final String title;
  final String content;
  final String? subtitle;
  final bool showArrow;
  final Widget? trailing;
  ListTileItemContent({
    Key? key,
    required this.title,
    required this.content,
    this.showArrow = true,
    this.subtitle,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: subtitle != null ? 6 : 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            SizedBox(width: 32),
            Expanded(
              child: Text(
                content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            trailing ??
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Color(0xFFCCCCCC),
                ),
          ],
        ),
        subtitle != null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              )
            : SizedBox(),
        SizedBox(height: subtitle != null ? 6 : 0),
      ],
    );
  }
}
