import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shopkeeper/app/modules/shop/models/social_media_model.dart';
import 'package:shopkeeper/widgets/index.dart';
import '../controllers/shop_controller.dart';
import 'edit_item_view.dart';

// ignore: must_be_immutable
class ShopView extends GetView<ShopController> {
  late BuildContext _context;

  /// 顶部信息
  Widget buildTopInfoGroup() {
    void _handleAvatarClick() {
      if (controller.state.shopAvatar.isEmpty) {
        controller.imagePicker();
      } else {
        // 图片查看页面
        final _viewPage = Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: BackButton(color: Colors.white),
          ),
          body: PhotoView(
            imageProvider: FileImage(
              File(controller.state.shopAvatar),
            ),
          ),
        );
        Get.to(() => _viewPage);
      }
    }

    void _handleAvatarRemove() {
      showCupertinoDialog(
        context: _context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('are_you_sure_remove_image'.tr),
            actions: [
              CupertinoDialogAction(
                child: Text('cancel'.tr, style: TextStyle(color: Colors.grey)),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                child: Text('confirm'.tr),
                onPressed: () async {
                  await controller.handleSetAssign('shopAvatar', '');
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    void _handleShopNameClick() {
      Get.to(
        () => EditItemView(
          title: 'shop.shop_name'.tr,
          value: controller.state.shopName,
          onTap: (value) => controller.handleSetAssign('shopName', value),
          maxLength: 50,
        ),
      );
    }

    void _handleMediaBarClick() {
      buildGetxBottomSheet(
        title: Text(
          'shop.social_media'.tr,
          style: TextStyle(fontSize: 16),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: controller.state.socialMedias.map((e) {
              SocialMediaModel element = SocialMediaModel.fromJson(e);
              Widget? _mWidget;
              return Obx(
                () => SwitchListTile(
                  value: element.active.value,
                  onChanged: (value) async {
                    String _link = '', _updateData;
                    if (value) {
                      var result = await Get.to(
                        () => EditItemView(
                          title: element.title,
                          value: element.link.value,
                        ),
                      );
                      if (result == '' || result == null) {
                        return;
                      }
                      _link = result;
                    }
                    element.link.value = _link;
                    element.active.value = value;
                    _updateData =
                        '{"link":"$_link","active":"${value ? '1' : '0'}"}';
                    controller.handleSetAssign(element.title, _updateData);
                  },
                  title: Text(element.title),
                  subtitle: (element.link.value).isNotEmpty
                      ? Text(element.link.value)
                      : _mWidget,
                  secondary: Image.asset(
                    element.logo,
                    color: (element.active).value ? element.color : Colors.grey,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }

    final shopAvatar = Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              onTap: () => _handleAvatarClick(),
              child: Container(
                color: Colors.grey.shade200,
                width: 80,
                height: 80,
                child: controller.state.shopAvatar.isEmpty
                    ? Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: Colors.grey.shade400,
                      )
                    : Image.file(
                        File(controller.state.shopAvatar),
                        gaplessPlayback: true, // 为false时点击输入框时图片闪动
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ),
        controller.state.shopAvatar.isEmpty
            ? SizedBox()
            : Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: () => _handleAvatarRemove(),
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
              ),
      ],
    );
    final shopName = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          controller.state.shopName,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(width: 4),
        Container(
          // margin: EdgeInsets.only(top: 2),
          child: Icon(
            Icons.edit,
            size: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
    final mediaBar = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...controller.state.socialMedias.map((e) {
          SocialMediaModel element = SocialMediaModel.fromJson(e);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Obx(
              () => Image.asset(
                element.logo,
                color: (element.active).value ? element.color : Colors.grey,
              ),
            ),
          );
        }),
        Container(
          child: Icon(
            Icons.more_horiz,
            color: Colors.grey,
          ),
        ),
      ],
    );

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          width: double.maxFinite,
          // color: Colors.white,
          child: Column(
            children: [
              shopAvatar,
              SizedBox(height: 8),
              InkWell(
                child: shopName,
                onTap: () => _handleShopNameClick(),
              ),
              SizedBox(height: 16),
              InkWell(
                child: mediaBar,
                onTap: () => _handleMediaBarClick(),
              ),
            ],
          ),
        ),
        // Divider(height: 0.5),
      ],
    );
  }

  /// 基本设置
  Widget buildBaseSetingGroup() {
    void buildPaymentMethodDialog2() => showCupertinoDialog(
          context: _context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('shop.other_payment_method'.tr),
              content: Column(
                children: controller.state.paymentMethods.map((element) {
                  return Obx(() => Material(
                        color: Colors.transparent,
                        child: SwitchListTile(
                          dense: true,
                          contentPadding: EdgeInsets.all(0),
                          value: (element['active'] as RxBool).value,
                          onChanged: (value) {
                            (element['active'] as RxBool).value = value;
                            controller.handleSetAssign(
                                element['title'] as String, value ? '1' : '0');
                          },
                          title: Text(
                            element['label'] as String,
                            style: TextStyle(
                              fontWeight: (element['active'] as RxBool).value
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ));
                }).toList(),
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text('done'.tr),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );

    return Column(
      children: [
        ListTileGroup(
          title: '基本设置',
          children: [
            ListTileItem(
              content: ListTileItemContent(
                title: 'shop.other_shipping_fee'.tr,
                content: controller.state.shippingFee,
              ),
              onTap: () {
                Get.to(
                  () => EditItemView(
                    title: 'shop.other_shipping_fee'.tr,
                    value: controller.state.shippingFee,
                    onTap: (value) =>
                        controller.handleSetAssign('shippingFee', value),
                    keyboardType: TextInputType.number,
                  ),
                );
              },
            ),
            ListTileItem(
              content: ListTileItemContent(
                title: 'shop.other_payment_method'.tr,
                content: controller.state.paymentMethodContent(),
              ),
              onTap: () => buildPaymentMethodDialog2(),
            ),
            ListTileItem(
              content: ListTileItemContent(
                title: 'shop.contact_number'.tr,
                content: controller.state.contactNumber,
              ),
              onTap: () {
                Get.to(
                  () => EditItemView(
                    title: 'shop.contact_number'.tr,
                    value: controller.state.contactNumber,
                    onTap: (value) =>
                        controller.handleSetAssign('contactNumber', value),
                    keyboardType: TextInputType.number,
                  ),
                );
              },
            ),
            ListTileItem(
              content: ListTileItemContent(
                title: 'shop.contact_address'.tr,
                content: controller.state.contactAddress,
              ),
              onTap: () {
                Get.to(
                  () => EditItemView(
                    title: 'shop.contact_address'.tr,
                    value: controller.state.contactAddress,
                    onTap: (value) =>
                        controller.handleSetAssign('contactAddress', value),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  /// 线上销售
  Widget buildOnlineSales() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          SwitchListTile(
            value: controller.state.onlineSales,
            onChanged: (value) =>
                controller.handleSetAssign('onlineSales', value ? '1' : '0'),
            title: controller.state.onlineSales
                ? Text(
                    '线上销售 - 开启',
                    style: TextStyle(fontSize: 24, color: Colors.blue),
                  )
                : Text(
                    '线上销售 - 关闭',
                    style: TextStyle(fontSize: 24),
                  ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(controller.state.onlineUrl),
                SizedBox(width: 8),
                Icon(Icons.content_copy, size: 16),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildDataSync() {
    return Column(
      children: [
        ListTileGroup(
          children: [
            ListTileItem(
              content: ListTileItemContent(
                title: '数据同步',
                content: controller.state.syncLastTime.isEmpty
                    ? '将数据同步至服务器'
                    : controller.state.syncLastTime,
              ),
            ),
            ListTileItem(
              content: ListTileItemContent(
                title: '本地货币',
                content: controller.state.localCurrencyText(),
              ),
              onTap: () {
                buildGetxBottomSheet(
                  title: Text('本地货币', style: TextStyle(fontSize: 16)),
                  body: Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Column(
                      children: controller.state.localCurrencyList.map(
                        (element) {
                          return Obx(
                            () => RadioListTile(
                              value: element['key'] as String,
                              groupValue: controller.state.localCurrency,
                              onChanged: (_) => controller.handleSetAssign(
                                  'localCurrency', element['key'] as String),
                              title: Text(element['label'] as String),
                              secondary: Text(element['symbols'] as String),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        title: Text('shop'.tr),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: GetX<ShopController>(
        init: controller,
        initState: (_) {},
        builder: (_) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTopInfoGroup(),
              SizedBox(height: 8),
              buildOnlineSales(),
              SizedBox(height: 16),
              buildDataSync(),
              SizedBox(height: 16),
              buildBaseSetingGroup(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
