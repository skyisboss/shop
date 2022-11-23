import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/marketing/data/export.dart';

class MarketingController extends GetxController {
  final addState = AddPageState();
  final listState = ListPageState();

  // 初始化数据库
  initData() async {
    DiscountDao dao = DiscountDao();
    // 如果表不存在则插入默认数据
    if (false == await dao.isTableExits()) {
      for (var i = 0; i < 40; i++) {
        var title = i % 2 == 0 ? '折扣' : '优惠劵';
        var addData = DiscountEntity(
          title: '$title $i',
          type: i % 2,
          discountAmount: (5 + i).toDouble(),
          amountType: 1,
          minAmount: 0,
          maxAmount: 0,
          totalNum: 100,
          expiredDate: DateTime.now().millisecondsSinceEpoch,
        );
        await dao.insert(addData);

        print('插入默认数据 $i');
      }
    }
    // 初始化列表数据
    listState.loadListData(type: 0);
    listState.loadListData(type: 1);
  }

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    listState.refreshController.map((e) {
      e.dispose();
    });
  }
}
