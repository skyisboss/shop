import 'package:flutter/material.dart';

/// 卡片面板
class MyCard extends StatelessWidget {
  MyCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.boxShadow,
    this.color,
    this.decoration,
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Color? color;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.symmetric(vertical: 16),
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16.0),
      decoration: decoration ??
          BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            boxShadow: boxShadow ??
                [
                  BoxShadow(
                    offset: const Offset(1, 2),
                    blurRadius: 9,
                    color: Colors.blue.withOpacity(0.1),
                  ),
                ],
          ),
      child: child,
    );
  }
}
