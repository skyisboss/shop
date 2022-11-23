import 'package:get/get.dart';

import 'package:shopkeeper/app/modules/check_cart/bindings/check_cart_binding.dart';
import 'package:shopkeeper/app/modules/check_cart/views/check_cart_view.dart';
import 'package:shopkeeper/app/modules/customer/bindings/customer_binding.dart';
import 'package:shopkeeper/app/modules/customer/views/customer_view.dart';
import 'package:shopkeeper/app/modules/finance/bindings/finance_binding.dart';
import 'package:shopkeeper/app/modules/finance/views/finance_view.dart';
import 'package:shopkeeper/app/modules/home/bindings/home_binding.dart';
import 'package:shopkeeper/app/modules/home/views/home_view.dart';
import 'package:shopkeeper/app/modules/inventory/bindings/inventory_binding.dart';
import 'package:shopkeeper/app/modules/inventory/views/inventory_view.dart';
import 'package:shopkeeper/app/modules/marketing/bindings/marketing_binding.dart';
import 'package:shopkeeper/app/modules/marketing/views/marketing_view.dart';
import 'package:shopkeeper/app/modules/mine/bindings/mine_binding.dart';
import 'package:shopkeeper/app/modules/mine/views/mine_view.dart';
import 'package:shopkeeper/app/modules/payment/bindings/payment_binding.dart';
import 'package:shopkeeper/app/modules/payment/views/payment_view.dart';
import 'package:shopkeeper/app/modules/pos/bindings/pos_binding.dart';
import 'package:shopkeeper/app/modules/pos/views/pos_view.dart';
import 'package:shopkeeper/app/modules/product/bindings/product_binding.dart';
import 'package:shopkeeper/app/modules/product/views/product_view.dart';
import 'package:shopkeeper/app/modules/report/bindings/report_binding.dart';
import 'package:shopkeeper/app/modules/report/views/report_view.dart';
import 'package:shopkeeper/app/modules/shop/bindings/shop_binding.dart';
import 'package:shopkeeper/app/modules/shop/views/shop_view.dart';
import 'package:shopkeeper/app/modules/welcome/bindings/welcome_binding.dart';
import 'package:shopkeeper/app/modules/welcome/views/welcome_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SHOP,
      page: () => ShopView(),
      binding: ShopBinding(),
    ),
    GetPage(
      name: _Paths.MINE,
      page: () => MineView(),
      binding: MineBinding(),
    ),
    GetPage(
      name: _Paths.POS,
      page: () => PosView(),
      binding: PosBinding(),
    ),
    GetPage(
      name: _Paths.CHECK_CART,
      page: () => CheckCartView(),
      binding: CheckCartBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.INVENTORY,
      page: () => InventoryView(),
      binding: InventoryBinding(),
    ),
    GetPage(
      name: _Paths.MARKETING,
      page: () => MarketingView(),
      binding: MarketingBinding(),
    ),
    GetPage(
      name: _Paths.FINANCE,
      page: () => FinanceView(),
      binding: FinanceBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER,
      page: () => CustomerView(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => ProductView(),
      binding: ProductBinding(),
    ),
  ];
}
