import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/customer/export.dart';

class CustomerController extends GetxController {
  final addState = AddState();
  final detailState = DetailState();
  final listState = ListState();

  final _searchInputFoucs = false.obs;
  set searchInputFoucs(e) => _searchInputFoucs.value = e;
  bool get searchInputFoucs => _searchInputFoucs.value;

  /// 筛选过滤
  // 选中的状态
  final filterValue = {
    'group': '',
    'birthday': '',
    'spend': '',
    'other': '',
  }.obs;
  isFilterValue() {
    bool isActive = false;
    for (var item in filterValue.values) {
      if (item != '') {
        isActive = true;
      }
    }
    return isActive;
  }

  /// 初始化数据
  initData() async {
    // 初始化数据库
    {
      SpendDao dao = SpendDao();
      if (!await dao.isTableExits()) {
        await dao.open();
        print('创建表=SpendDao');
      }
    }
    {
      ArrearDao dao = ArrearDao();
      if (!await dao.isTableExits()) {
        await dao.open();
        print('创建表=ArrearDao');
      }
    }
    {
      CustomerDao dao = CustomerDao();
      if (!await dao.isTableExits()) {
        await dao.open();
        print('创建表=CustomerDao');
      }
    }
    {
      GroupDao dao = GroupDao();
      if (!await dao.isTableExits()) {
        // 插入默认数据
        await dao.insert(GroupEntity(groupName: 'VIP-1', groupDiscount: 0));
        await dao.insert(GroupEntity(groupName: 'VIP-2', groupDiscount: 3));
        await dao.insert(GroupEntity(groupName: 'VIP-3', groupDiscount: 6));
        print('创建表=GroupDao');
      }
    }
  }

  @override
  void onInit() {
    initData();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
