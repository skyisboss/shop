// ignore_for_file: non_constant_identifier_names

Map<String, String> _home = {
  'home.today_order': '今日订单',
  'home.today_transaction': '今日成交',
  'home.connect_device': '连接设备',
  'home.shopping': '销售',
  'home.inventory': '库存',
  'home.marketing': '营销',
  'home.report': '报表',
  'home.finance': '资金',
  'home.customer': '顾客',
  'home.tutorial': '教程',
};
Map<String, String> _shop = {
  'shop.shop_name': '店铺名称',
  'shop.open_status': '正在营业',
  'shop.close_status': '暂停营业',
  //数据同步分组
  'shop.group_sync_data': '数据同步',
  'shop.sync_to_server': '同步至服务器',
  'shop.sync_last_time': '最近 @date',
  'shop.do_it_now': '立即操作',
  'shop.are_you_sure_want_sync_data': '确定同步数据吗？',
  //联系信息分组
  'shop.group_contact': '联系信息',
  'shop.contact_number': '联系电话',
  'shop.contact_address': '联系地址',
  //其他分组
  'shop.group_other': '其他',
  'shop.other_shipping_fee': '运费配置',
  'shop.other_payment_method': '支付方式',
  // 弹出窗
  'shop.social_media': '社群媒体',

  'are_you_sure_remove_image': '确定移除图片吗？',
};

Map<String, String> _mine = {
  'mine.data': '数据同步',
  'mine.last_action': '最近 @date',
  'mine.equipment': '设备',
  'mine.other': '其他',
  'mine.sync_to_service': '同步至服务器',
  'mine.update_to_local': '更新至本地',
  'mine.scan_print': '扫描和打印',
  'mine.barcodes_labels': '条码和标签',
  'mine.permissions_security': '权限和安全',
  'mine.upgrade': '检测更新',
  'mine.privacy_agreement': '隐私协议',
  'mine.about_us': '关于我们',
  'mine.reset_data': '重置数据',
};

Map<String, String> zh_CN = {
  //公用语言
  "app_name": "店管家",
  'home': '首页',
  'shop': '店铺',
  'mine': '我的',
  'confirm': '确定',
  'cancel': '取消',
  'done': '完成',
  'please_typing': '请输入 @key',

  //首页
  ..._home,

  // 我的
  ..._mine,

  //店铺页面
  ..._shop,
};
