import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/widgets/index.dart';

import '../export.dart';
import 'widgets/group_setting.dart';

class AddView extends GetView<CustomerController> {
  const AddView({Key? key, this.uid}) : super(key: key);
  final int? uid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MyAppBar(
          title: uid == null ? '添加客户' : '编辑客户',
          actions: [
            MyAppBar.useActionButton(onTap: () {
              controller.addState.onDone();
            }),
          ],
        ),
        body: GetX<CustomerController>(
          init: CustomerController(),
          initState: (value) {
            // 初始化数据
            value.controller!.addState.initGroupData();
          },
          builder: (_) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  MyImagePicker(
                    url: controller.addState.avatar,
                    siveDirName: 'avatar',
                    onPicker: (e) => controller.addState.imagePicker(e),
                    onRemove: (e) => controller.addState.imagePicker(e),
                  ),
                  SizedBox(height: 32),
                  buildInputList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildInputList() {
    var addState = controller.addState;
    return Column(
      children: [
        ListTileGroup(
          title: '',
          children: [
            TextFieldItem(
              title: '用户名',
              controller: TextEditingController(text: addState.username),
              onChanged: (e) => addState.addData.value.username = e,
            ),
            ClickTileItem(
              title: '用户组',
              content: addState.getGroupName(),
              onTap: () => buildGroupSetting(),
              arrow: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.orange.shade700,
              ),
            ),
            ClickTileItem(
              title: '性别',
              customer: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        Radio(
                            value: 1,
                            groupValue: addState.gender,
                            onChanged: (e) {
                              addState.addData
                                  .update((val) => val?.gender = e as int);
                            }),
                        Text('男'),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  InkWell(
                    child: Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: addState.gender,
                          onChanged: (e) {
                            addState.addData
                                .update((val) => val?.gender = e as int);
                          },
                        ),
                        Text('女'),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
            ClickTileItem(
              title: '出生日期',
              content: addState.birthday.isNotEmpty ? addState.birthday : '请选择',
              onTap: () => addState.datePicker(),
            ),
            TextFieldItem(
              title: '联系电话',
              controller: TextEditingController(text: addState.telephone),
              onChanged: (e) => addState.addData.value.telephone = e,
            ),
            TextFieldItem(
              title: '联系地址',
              controller: TextEditingController(text: addState.address),
              onChanged: (e) => addState.addData.value.address = e,
            ),
            TextFieldItem(
              title: '备注',
              controller: TextEditingController(text: addState.remark),
              onChanged: (e) => addState.addData.value.remark = e,
            ),
          ],
        ),
      ],
    );
  }
}
