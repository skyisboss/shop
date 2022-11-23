import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/widgets/index.dart';

import '../export.dart';

class WalletView extends GetView<FinanceController> {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('账户钱包', style: TextStyle(color: Colors.black87)),
        leading: CloseButton(),
        actions: [
          IconButton(
            onPressed: () => controller.walletState.handleAdd(null),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: GetX<FinanceController>(
        init: FinanceController(),
        initState: (_) {
          controller.walletState.initData();
        },
        builder: (_) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                ...controller.walletState.walletList
                    .map((element) => buildListItem(element)),
                // ...List.generate(5, (index) => buildListItem(index)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildListItem(WalletEntity element) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 0),
          child: ListTile(
            leading: CircleAvatar(
              child: Text('0'),
            ),
            title: Text(element.name!),
            trailing: element.id == 1
                ? null
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () =>
                            controller.walletState.handleAdd(element),
                        icon: Icon(Icons.edit, size: 20),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.walletState.handleDelete(element.id!);
                        },
                        icon: Icon(Icons.delete, size: 20),
                      )
                    ],
                  ),
          ),
        ),
        Container(
          height: 16,
          color: Color(0xfff2f2f2),
        ),
      ],
    );
  }

  popupAddDialog(data) {
    final inputContent = Material(
      color: Colors.transparent,
      child: Container(
        height: 55,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          controller: TextEditingController(),
          maxLength: 30,
          decoration: InputDecoration(
            hintText: '输入账户名称',
            hintStyle: TextStyle(fontSize: 13),
            filled: true,
            fillColor: Colors.grey.shade300,
            contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
      ),
    );
    cupertinoDialog(
      Get.context as BuildContext,
      title: Text(data == null ? '添加账户' : '编辑账户'),
      content: inputContent,
      onConfirm: () {},
    );
  }
}
