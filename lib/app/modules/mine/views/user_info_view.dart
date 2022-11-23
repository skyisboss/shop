import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/widgets/index.dart';

import 'setting_auth.dart';
import 'setting_pwd_view.dart';

class UserInfoView extends StatelessWidget {
  BuildContext? _context;
  UserInfoView({Key? key}) : super(key: key);

  Widget buildAvatar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PKmp4',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text('创始人'),
        ],
      ),
    );
  }

  Widget buildListTile() {
    final selectLang = ListTileItem(
      content: ListTileItemContent(
        title: '语言选择',
        content: '简体中文',
      ),
      onTap: () {
        buildGetxBottomSheet(
          title: Text('语言选择', style: TextStyle(fontSize: 16)),
          body: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Column(
              children: List.generate(
                3,
                (index) => RadioListTile(
                  value: 'key',
                  groupValue: 'key2',
                  onChanged: (_) => {},
                  title: Text('label'),
                  secondary: Text('symbols'),
                ),
              ),
            ),
          ),
        );
      },
    );

    final authSetting = ListTileItem(
      title: '权限控制',
      onTap:
          // () => Get.to(() => SettingAuth()),
          () => Get.to(
        () => InputPasscode(
          titles: ['请创建密码', '请再次输入密码', '密码错误，请重写输入'],
          callback: () => Get.off(() => SettingAuth()),
        ),
      ),
    );
    final pwdSetting = ListTileItem(
      title: '修改密码',
      onTap: () => Get.to(() => SettingPwdView()),
    );
    final restData = ListTileItem(
      onTap: () {
        showCupertinoDialog(
          context: _context!,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('确定要重置数据吗'),
              content: Text('这将会清空数据并重置至初始状态'),
              actions: [
                CupertinoDialogAction(
                  child: Text(
                    'cancel'.tr,
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoDialogAction(
                  child: Text('confirm'.tr),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      },
      content: Row(
        children: [
          Icon(Icons.warning, size: 16, color: Colors.red),
          SizedBox(width: 6),
          Text(
            '重置数据',
            style: TextStyle(color: Colors.red),
          )
        ],
      ),
    );

    return Column(
      children: [
        ListTileGroup(
          children: [
            selectLang,
            authSetting,
            pwdSetting,
            SizedBox(height: 32),
            restData,
          ],
        ),
        SizedBox(height: 32),
        TextButton(
          onPressed: () async {
            showCupertinoDialog(
              context: _context!,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text('确定退出登录吗'),
                  actions: [
                    CupertinoDialogAction(
                      child: Text(
                        'cancel'.tr,
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CupertinoDialogAction(
                      child: Text('confirm'.tr),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('退出登录'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAvatar(),
          SizedBox(height: 16),
          buildListTile(),
        ],
      ),
    );
  }
}
