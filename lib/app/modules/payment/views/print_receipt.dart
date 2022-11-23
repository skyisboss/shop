import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shopkeeper/app/routes/app_pages.dart';

GlobalKey _globalKey = GlobalKey();

class PrintReceiptView extends StatelessWidget {
  const PrintReceiptView({Key? key}) : super(key: key);

  Widget buildTicketPaper(BuildContext context, {required Widget child}) {
    // 屏幕宽度 - 两边留白32 - 三角形宽度12
    final _width = MediaQuery.of(context).size.width;
    final _size = ((_width - 40) / 12).floorToDouble();
    final Widget buildTriangle = Container(
      width: 12,
      height: 0,
      decoration: BoxDecoration(
        border: Border(
          // 四个值 top right bottom left
          bottom: BorderSide(
              color: Colors.white, width: 10, style: BorderStyle.solid),
          right: BorderSide(
              color: Colors.transparent, width: 6, style: BorderStyle.solid),
          left: BorderSide(
              color: Colors.transparent, width: 6, style: BorderStyle.solid),
        ),
      ),
    );
    final List<Widget> _triangles =
        List.generate(_size.toInt(), (index) => buildTriangle);
    final _triangleHead = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _triangles,
    );

    return Column(
      children: [
        _triangleHead,
        child,
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(math.pi),
          child: _triangleHead,
        ),
      ],
    );
  }

  Widget buildText(
    String text, {
    double? size,
    double? margin,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin ?? 0),
      child: Text(
        text,
        style: TextStyle(fontSize: size ?? 14),
      ),
    );
  }

  Future<void> _capturePng() async {
    //检查是否有存储权限
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();

      print(status);
      return;
    }

    final RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    //保存的图片比较模糊 boundary.toImage() 方法加上参数pixelRatio:2.5
    final ui.Image image = await boundary.toImage(pixelRatio: 2.5);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    final result = await ImageGallerySaver.saveImage(pngBytes);
    print('海报已保存到相册');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        elevation: 0.5,
        // leading: SizedBox(),
        actions: [
          IconButton(
              onPressed: () async {
                print('_capturePng');
                _capturePng();
              },
              icon: Icon(Icons.ios_share))
        ],
        title: Text('打印收据'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Expanded(
            child: RepaintBoundary(
              key: _globalKey,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: buildTicketPaper(
                  context,
                  child: Container(
                    // height: 500,

                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildText('店管家销售管理系统', size: 18),
                              buildText('电话&微信： 18888888888', margin: 2),
                              buildText('地址： 广州白云区嘉禾望岗地铁站118', margin: 1),
                            ],
                          ),
                        ),
                        Divider(),
                        buildText('流水号：20220202001'),
                        buildText('流水号：2022/02/02/ 15:30'),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText('数量'),
                            buildText('单价'),
                            buildText('总计'),
                          ],
                        ),

                        /// 购买的项目
                        ...List.generate(3, (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              buildText('统一老坛牛肉面'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildText('X 8'),
                                  buildText('￥8.88'),
                                  buildText('￥8.88'),
                                ],
                              ),
                            ],
                          );
                        }),
                        SizedBox(height: 10),
                        Divider(),
                        buildText('共 8 件', size: 18),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText('总计', size: 26),
                            buildText('￥888.00', size: 26),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [buildText('收款 ￥1000.00')],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [buildText('找零 ￥800.00')],
                        ),
                        SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [buildText('Think You', size: 30)],
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1),
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: Center(
              child: ToggleButtons(
                fillColor: Colors.blue.withOpacity(0.04),
                borderRadius: BorderRadius.circular(50.0),
                constraints: BoxConstraints(minHeight: 36.0),
                isSelected: [true, true],
                onPressed: (index) {
                  if (index == 0) {
                  } else {
                    Get.offAndToNamed(Routes.POS);
                  }
                },
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36.0),
                    child: Row(
                      children: [
                        Icon(Icons.print),
                        SizedBox(width: 10),
                        Text('打印票据'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36.0),
                    child: Row(
                      children: [
                        Text('订单完成'),
                        SizedBox(width: 10),
                        Icon(Icons.verified),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
