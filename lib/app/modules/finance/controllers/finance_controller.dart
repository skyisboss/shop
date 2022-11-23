import 'package:get/get.dart';

import '../export.dart';

class FinanceController extends GetxController {
  final walletState = WalletState();
  final fundsState = FundsState();
  final detailState = DetailState();
  final test = 'test'.obs;

  initData() async {
    // 实例化钱包数据
    {
      WalletDao dao = WalletDao();

      if (!await dao.isTableExits()) {
        await dao.insert(WalletEntity(name: '现金账户', logo: ''));
        await dao.insert(WalletEntity(name: '欠款账户', logo: ''));
        await dao.insert(WalletEntity(name: '移动支付', logo: ''));
        await dao.insert(WalletEntity(name: '刷卡支付', logo: ''));
        print('创建表=WalletDao');
      }
    }

    // 实例化资金记录
    {
      FundsDao dao = FundsDao();
      if (!await dao.isTableExits()) {
        await dao.open();
        print('创建表=FundsDao');
      }
    }
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
  void onClose() {}
}
