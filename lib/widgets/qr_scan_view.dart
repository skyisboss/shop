import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';

class QrScanView extends StatefulWidget {
  const QrScanView({Key? key}) : super(key: key);

  @override
  _QrScanViewState createState() => _QrScanViewState();
}

class _QrScanViewState extends State<QrScanView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  late bool isFalsh;

  @override
  void initState() {
    isFalsh = false;
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      /// 扫描成功时给予振动反馈
      if (await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate(duration: 10);
      }

      /// 避免扫描结果多次回调
      controller.dispose();

      Get.back(result: scanData.code ?? '');
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderLength: 40,
                borderWidth: 5,
                // cutOutSize: scanArea,
                cutOutWidth: 250,
                cutOutHeight: 200,
                cutOutBottomOffset: 50,
                borderColor: Colors.green,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.close,
                    size: 26,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFalsh ? Icons.flash_off : Icons.highlight,
                    size: 26,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    setState(() {
                      isFalsh = !isFalsh;
                    });
                    try {
                      await controller?.toggleFlash();
                    } catch (e) {
                      print('无法打开闪光灯 $e');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
