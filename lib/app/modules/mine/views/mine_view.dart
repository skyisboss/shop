import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:shopkeeper/widgets/index.dart';
import '../controllers/mine_controller.dart';
import 'user_info_view.dart';

class MineView extends GetView<MineController> {
  _userInfo() => ListTileGroup(
        padding: EdgeInsets.all(0),
        children: [
          InkWell(
            onTap: () => Get.to(() => UserInfoView()),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          // spreadRadius: 1,
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.grey.shade100,
                      child: Icon(Icons.person, size: 33),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'pkmp4',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '创始人',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xFFCCCCCC),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  _device() => ListTileGroup(
        title: '设备',
        children: [
          ListTileItem(title: '扫描打印'),
          ListTileItem(title: '票据标签'),
          ListTileItem(title: '条形码'),
        ],
      );
  _other() => ListTileGroup(
        title: '其他',
        children: [
          ListTileItem(
            content: ListTileItemContent(title: '版本更新', content: 'Beta 1.0.1'),
          ),
          ListTileItem(title: '用户协议'),
          ListTileItem(title: '关于我们'),
        ],
      );
  _data() {
    return ListTileGroup(
      // title: '关于',
      children: [
        ListTileItem(title: '使用教程'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      bottomNavigationBar: buildBottomNavigationBar(),
      appBar: AppBar(
        title: Text('mine'.tr),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _userInfo(),
            SizedBox(height: 16),
            _device(),
            SizedBox(height: 16),
            _other(),
            _data(),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
