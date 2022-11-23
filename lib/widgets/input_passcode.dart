import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/common/style/colors.dart';

class InputPasscode extends StatelessWidget {
  Function() callback;
  final List<String> titles;
  InputPasscode({
    Key? key,
    required this.titles,
    required this.callback,
  }) : super(key: key);

  final passcode = [].obs;
  final rePwd = ''.obs;
  final _opacity = 1.0.obs;
  final _isLock = false.obs;
  final stepIndex = 0.obs;
  // final _hintText = '请创建密码'.obs;

  Widget buildPassCircular() {
    Widget buildCircular({Color? color}) => Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: MyColors.primaryColor),
          ),
        );
    return Column(
      children: [
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...passcode.map(
                    (element) => buildCircular(color: MyColors.primaryColor)),
                ...List.generate(
                    6 - passcode.length, (index) => buildCircular())
              ],
            )),
        SizedBox(height: 16),
        Text(titles[stepIndex.value]),
      ],
    );
  }

  Widget buildNumberInput() {
    return Container(
      padding: EdgeInsets.all(26),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.8,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: 12,
        itemBuilder: (_, index) {
          Widget box;
          var numberText = index + 1;
          if (numberText == 10) {
            box = SizedBox();
          } else if (numberText == 12) {
            box = InkWell(
              onTap: () => passcode.isNotEmpty ? passcode.removeLast() : null,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Icon(
                    Icons.backspace,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            );
          } else {
            numberText = numberText == 11 ? 0 : numberText;
            box = InkWell(
              onTap: () {
                if (_isLock.value == false) {
                  passcode.add(numberText);
                }
                if (passcode.length == 6) {
                  stepIndex.value = 1;
                  if (rePwd.value.isNotEmpty) {
                    if (passcode.join().toString() == rePwd.value) {
                      _isLock.value = true;
                      print('密码正确');
                      callback();
                      return;
                    } else {
                      stepIndex.value = 2;
                      rePwd.value = "";
                    }
                  }
                  _isLock.value = true;
                  _opacity.value = 0;
                  rePwd.value = passcode.join().toString();
                  Timer.periodic(Duration(milliseconds: 250), (t) {
                    _opacity.value = 1;
                    passcode.value = [];
                    _isLock.value = false;
                    t.cancel();
                  });
                  print(passcode);
                  print(rePwd.value);
                }
              },
              child: Center(
                child: Text(
                  numberText.toString(),
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }

          return box;
        },
      ),
    );
  }

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
        width: double.maxFinite,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => AnimatedOpacity(
                      opacity: _opacity.value,
                      duration: Duration(seconds: 0),
                      child: buildPassCircular(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: buildNumberInput(),
            ),
          ],
        ),
      ),
    );
  }
}
