import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shopkeeper/widgets/index.dart';

class MyImagePicker extends StatelessWidget {
  MyImagePicker({
    Key? key,
    this.url,
    this.size = 80.0,
    this.siveDirName = 'product',
    this.onPicker,
    this.onRemove,
  }) : super(key: key);

  final String? url;
  final double? size;
  final String? siveDirName;
  final Function(String)? onPicker;
  final Function(String)? onRemove;

  final ImagePicker picker = ImagePicker();
  final filePath = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (url != null && url!.isNotEmpty) {
        filePath.value = url!;
      }

      final removeBtn = Positioned(
        right: 0,
        top: 0,
        child: InkWell(
          // 移除图片操作
          onTap: () {
            cupertinoDialog(
              context,
              title: Text('确定删除吗？'),
              onConfirm: handleRemove,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.white, spreadRadius: 3)],
            ),
            child: Icon(Icons.cancel, color: Colors.red.shade200),
          ),
        ),
      );

      final child =
          filePath.value.isNotEmpty && File(filePath.value).existsSync()
              ? Image.file(
                  File(filePath.value),
                  gaplessPlayback: true, // 为false时点击输入框时图片闪动
                  fit: BoxFit.cover,
                )
              : Icon(
                  Icons.add_a_photo,
                  size: 30,
                  color: Colors.grey.shade400,
                );

      return Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: InkWell(
              // 点击选择图片
              onTap: handleShowDialog,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  color: Colors.grey.shade200,
                  width: size,
                  height: size,
                  child: child,
                ),
              ),
            ),
          ),
          Visibility(
            visible: filePath.value.isNotEmpty,
            child: removeBtn,
          )
        ],
      );
    });
  }

  handleRemove() {
    File file = File(filePath.value);
    try {
      if (file.existsSync()) {
        file.deleteSync();
        if (onRemove != null) {
          onRemove!(filePath.value);
        }
      }
      filePath.value = '';
    } catch (e) {
      print('删除失败 $e');
    }
  }

  handlePicker(int mode) async {
    Navigator.pop(Get.context!);

    final XFile? image;
    if (mode == 0) {
      //拍摄图片
      image = await picker.pickImage(source: ImageSource.camera);
    } else {
      //选择文件
      image = await picker.pickImage(source: ImageSource.gallery);
    }

    if (image?.path == null) {
      return;
    }

    File oldFile = File(image!.path.toString());

    /// 获取应用程序目录文件 创建目标路径
    final dir = await getApplicationSupportDirectory();

    /// 保存路径 var siveDir = widget.siveDir ?? 'product';
    var savePath = Directory('${dir.path}/$siveDirName');
    if (!await savePath.exists()) {
      await savePath.create();
    }
    // 保存目标
    File newFile = File('${savePath.path}/${image.name}');

    // 复制文件
    try {
      await oldFile.copy(newFile.path);
      filePath.value = newFile.path;
      if (onPicker != null) {
        onPicker!(newFile.path);
      }

      // 删除旧文件
      oldFile.deleteSync();
    } catch (e) {
      print("复制失败 $e");
    }
  }

  handleShowDialog() {
    // 如果已存在图片，点击时跳转到浏览图片页面
    if (filePath.value.isNotEmpty) {
      Get.to(
        () => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
          body: PhotoView(
            imageProvider: FileImage(
              File(filePath.value),
            ),
          ),
        ),
      );
    } else {
      cupertinoDialog(
        Get.context!,
        actions: [
          CupertinoDialogAction(
            child: Text('拍照'),
            onPressed: () => handlePicker(0),
          ),
          CupertinoDialogAction(
            child: Text('图库'),
            onPressed: () => handlePicker(1),
          ),
          CupertinoDialogAction(
            child: Text('cancel'.tr, style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(Get.context!);
            },
          ),
        ],
      );
    }
  }
}

class MyImagePicker88 extends StatefulWidget {
  const MyImagePicker88({
    Key? key,
    this.url = '',
    this.size = 80.0,
    this.siveDirName = 'product',
    this.onPicker,
    this.onRemove,
  }) : super(key: key);

  final String? url;
  final double? size;
  final String? siveDirName;
  final Function(String)? onPicker;
  final Function(String)? onRemove;

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<MyImagePicker88> {
  late String imagePath;

  @override
  initState() {
    super.initState();
    imagePath = widget.url ?? '';
  }

  handleRemove() {
    File file = File(imagePath);
    try {
      if (file.existsSync()) {
        file.deleteSync();
      }
      setState(() {
        imagePath = '';
      });
      if (widget.onRemove != null) {
        widget.onPicker!(imagePath);
      }
    } catch (e) {
      print('删除失败 $e');
    }
  }

  handlePicker() async {
    // 如果已存在图片，点击时跳转到浏览图片页面
    if (imagePath.isNotEmpty) {
      Get.to(
        () => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
          body: PhotoView(
            imageProvider: FileImage(
              File(imagePath),
            ),
          ),
        ),
      );
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result == null) return;
    File file = File(result.files.single.path.toString());

    /// 获取应用程序目录文件 创建目标路径
    final dir = await getApplicationSupportDirectory();

    /// 保存路径
    // var siveDir = widget.siveDir ?? 'product';
    var savePath = Directory('${dir.path}/${widget.siveDirName!}');

    if (false == await savePath.exists()) {
      await savePath.create();
    }
    var _timeNow = DateTime.now().millisecondsSinceEpoch.toString();
    File target =
        File('${savePath.path}/${_timeNow}_${result.files.single.name}');

    try {
      // 复制文件
      await file.copy(target.path);
      setState(() {
        imagePath = target.path;
      });
      if (widget.onPicker != null) {
        widget.onPicker!(imagePath);
      }
    } catch (e) {
      print("复制失败 $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final removeBtn = Positioned(
      right: 0,
      top: 0,
      child: InkWell(
        // 移除图片操作
        onTap: () {
          cupertinoDialog(
            context,
            title: Text('确定删除图片吗？'),
            onConfirm: () async => await handleRemove(),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 3,
              )
            ],
          ),
          child: Icon(Icons.cancel, color: Colors.red.shade200),
        ),
      ),
    );

    final imageShow = imagePath.isNotEmpty && File(imagePath).existsSync()
        ? Image.file(
            File(imagePath),
            gaplessPlayback: true, // 为false时点击输入框时图片闪动
            fit: BoxFit.cover,
          )
        : Icon(
            Icons.add_a_photo,
            size: 30,
            color: Colors.grey.shade400,
          );

    final imageWrap = Container(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          // 点击选择图片
          onTap: () => handlePicker(),
          child: Container(
            color: Colors.grey.shade200,
            width: widget.size,
            height: widget.size,
            child: imageShow,
          ),
        ),
      ),
    );

    return Stack(
      children: [
        imageWrap,
        Visibility(
          visible: imagePath.isNotEmpty,
          child: removeBtn,
        )
      ],
    );
  }
}
