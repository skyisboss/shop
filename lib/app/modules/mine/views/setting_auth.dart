import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/mine/controllers/mine_controller.dart';
import 'package:shopkeeper/common/style/colors.dart';

class SettingAuth extends StatelessWidget {
  SettingAuth({Key? key}) : super(key: key);
  final controller = MineController();

  Widget buildAuthList() {
    return Column(
      children: controller.state.authPages.map((element) {
        var _active = element['active'] as RxBool;
        var _label = element['label'] as String;
        return Column(
          children: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SwitchListTile(
                  value: _active.value,
                  onChanged: (value) {
                    _active.value = value;
                  },
                  title: Text(
                    _label,
                    style: TextStyle(
                      color: _active.value ? Colors.blue : Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
            // Divider(height: 0.5),
            Container(
              height: 8,
              color: Color(0xFFF2F2F2),
            )
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '设置权限',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.close),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        actions: [
          Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 8,
            ),
            child: TextButton(
              onPressed: () {},
              child: Text('取消控制'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: buildAuthList(),
      ),
    );
  }
}
