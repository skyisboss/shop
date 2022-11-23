import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditItemView extends StatelessWidget {
  final String title;
  final String? value;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Function(String)? onTap;
  EditItemView({
    Key? key,
    required this.title,
    this.value,
    this.onTap,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textController = TextEditingController(text: value ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextButton(
              onPressed: () {
                if (onTap != null) {
                  onTap!(_textController.text);
                }

                Get.back(result: _textController.text);
              },
              child: Text('done'.tr),
            ),
          ),
        ],
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          maxLines: maxLines ?? 5,
          maxLength: maxLength ?? 30,
          autofocus: true,
          controller: _textController,
          keyboardType: keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'please_typing'.trParams({'key': title}),
          ),
        ),
      ),
    );
  }
}
