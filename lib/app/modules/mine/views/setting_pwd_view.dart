import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/common/style/colors.dart';

class SettingPwdView extends StatelessWidget {
  SettingPwdView({Key? key}) : super(key: key);
  final TextEditingController _textEditingController = TextEditingController();

  Widget buildTitle() => Center(
        child: Column(
          children: [
            Text(
              '修改登录密码',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('账户 pkmp4'),
          ],
        ),
      );
  Widget buildInputItem(hintText) {
    final _show = false.obs;
    return TextFormField(
      controller: _textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.primaryColor),
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _textEditingController.text.isEmpty
                ? SizedBox()
                : IconButton(
                    onPressed: () => _textEditingController.clear(),
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ),
            Obx(
              () => IconButton(
                onPressed: () => _show.value = !_show.value,
                icon: Icon(
                  _show.value ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInput() => Column(
        children: [
          buildInputItem('请输入旧密码'),
          SizedBox(height: 16),
          buildInputItem('请输入新密码'),
          SizedBox(height: 32),
          Container(
            width: double.maxFinite,
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('确定'),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.close),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildTitle(),
            SizedBox(height: 56),
            buildInput(),
          ],
        ),
      ),
    );
  }
}
