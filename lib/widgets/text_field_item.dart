import 'package:flutter/material.dart';

class TextFieldItem extends StatelessWidget {
  const TextFieldItem({
    Key? key,
    required this.title,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.enabled = true,
    this.filled = false,
    this.fillColor,
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController? controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final bool? enabled;
  final bool? filled;
  final Color? fillColor;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: maxLines! > 1 ? 12 : 14),
          child: Text(title),
        ),
        SizedBox(width: 16),
        Expanded(
          child: TextField(
            enabled: enabled,
            focusNode: focusNode,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            controller: controller,
            onChanged: onChanged,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: filled,
              fillColor: fillColor,
              hintText: hintText.isEmpty ? '输入$title' : hintText,
              border: InputBorder.none,
              hintStyle: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ],
    );

    final wrap = Container(
      constraints: BoxConstraints(minHeight: 50.0),
      margin: const EdgeInsets.only(left: 16.0),
      width: double.infinity,
      child: child,
    );

    return wrap;
  }
}
