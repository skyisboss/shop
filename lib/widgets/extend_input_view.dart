import 'package:flutter/material.dart';
import 'package:shopkeeper/widgets/index.dart';

class ExtendInputView extends StatelessWidget {
  const ExtendInputView({
    Key? key,
    required this.pageTitle,
    this.inputData,
    this.controller,
  }) : super(key: key);
  final String pageTitle;
  final String? inputData;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: pageTitle,
        actions: [
          appBarDoneButton('保存', onTap: () {}),
        ],
      ),
    );
  }
}
