import 'package:get/get.dart';
import '../page/tab/tab.dart';
import '../page/tab/market/stock_detail/stock_detail_page.dart';
import '../page/tab/home/deposit/deposit_page.dart';
import '../page/tab/home/new_deposit/new_deposit_page.dart';
import '../page/tab/home/new_deposit/deposit_application_page.dart';
import '../page/tab/home/new_deposit/deposit_success_page.dart';
import '../page/test/test_page.dart';
import '../page/main_page/main_page.dart';
import '../page/main_page/relaxation_space/relaxation_space.dart';
import '../page/main_page/relaxation_space/spirit/spirit.dart';
import '../page/start_page/start_page.dart';

class FRoute {
  static const String main = '/main';
  static const String start = '/start';
  static const String tab = '/tab';
  static const String stockDetail = '/stock_detail_page';
  static const String deposit = '/deposit_page';
  static const String newDeposit = '/newDeposit';
  static const String newDepositApplication = '/newDepositApplication';
  static const String newDepositSuccess = '/newDepositSuccess';
  static const String demo = '/demo';
  static const String ecommerce = '/ecommerce';
  static const String test = '/test';
  static const String relaxationSpace = '/relaxation_space';
  static const String spirit = '/spirit';

  static List<GetPage> getPages = [
    GetPage(name: main, page: () => MainPage()),
    GetPage(name: start, page: () => StartPage()),
    GetPage(name: tab, page: () => TabPage()),
    GetPage(name: stockDetail, page: () => StockDetailPage()),
    GetPage(name: deposit, page: () => DepositPage()),
    GetPage(name: newDeposit, page: () => NewDepositPage()),
    GetPage(
      name: newDepositApplication,
      page: () => DepositApplicationPage(),
    ),
    GetPage(name: newDepositSuccess, page: () => DepositSuccessPage()),
    GetPage(name: test, page: () => TestPage()),
    GetPage(name: relaxationSpace, page: () => RelaxationSpace()),
    GetPage(name: spirit, page: () => Spirit()),
  ];

  static push(
    String name, {
    arguments,
    Function(dynamic)? result,
    bool? preventDuplicates,
  }) {
    Get.toNamed(
      name,
      arguments: arguments,
      preventDuplicates: preventDuplicates != null ? preventDuplicates : true,
    )?.then((value) {
      result?.call(value);
    });
  }

  static offAndToNamed(String name, {arguments, Function? result}) {
    Get.offAndToNamed(name, arguments: arguments)?.then((value) {
      result?.call(value);
    });
  }

  static offAll(String name, {arguments}) {
    // Get.offAllNamed(name);
    Get.offNamedUntil(name, (route) => false, arguments: arguments);
  }

  static toTab(
    int index, {
    int? childIndex,
    Map<String, dynamic>? additionalArgs,
  }) {
    // 跳转到 Tab 页面，并带上 index 参数
    Map<String, dynamic> args = {"index": index};
    if (childIndex != null) {
      args["childIndex"] = childIndex;
    }
    if (additionalArgs != null) {
      args.addAll(additionalArgs);
    }
    Get.offNamedUntil(FRoute.tab, (route) => false, arguments: args);
  }
}
