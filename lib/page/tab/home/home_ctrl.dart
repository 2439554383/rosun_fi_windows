import 'package:get/get.dart';
import '../../../util/app_component.dart';
import '../../../util/f_route.dart';

class HomeCtrl extends GetxController {
  List<Map<String, dynamic>> stockList = [
    {
      'name': '腾讯控股',
      'code': '00700',
      'annualized': '+12.5%',
      'shares': '1000',
      'minEarnings': '¥1,250',
      'id': 1,
    },
    {
      'name': '阿里巴巴',
      'code': '09988',
      'annualized': '+15.2%',
      'shares': '800',
      'minEarnings': '¥1,216',
      'id': 2,
    },
    {
      'name': '美团',
      'code': '03690',
      'annualized': '+18.7%',
      'shares': '600',
      'minEarnings': '¥1,122',
      'id': 3,
    },
    {
      'name': '小米集团',
      'code': '01810',
      'annualized': '+9.8%',
      'shares': '1500',
      'minEarnings': '¥1,470',
      'id': 4,
    },
    {
      'name': '比亚迪',
      'code': '01211',
      'annualized': '+22.3%',
      'shares': '400',
      'minEarnings': '¥892',
      'id': 5,
    },
    {
      'name': '宁德时代',
      'code': '300750',
      'annualized': '+16.9%',
      'shares': '300',
      'minEarnings': '¥507',
      'id': 6,
    },
    {
      'name': '东方财富',
      'code': '300059',
      'annualized': '+11.4%',
      'shares': '2000',
      'minEarnings': '¥2,280',
      'id': 7,
    },
    {
      'name': '五粮液',
      'code': '000858',
      'annualized': '+13.6%',
      'shares': '500',
      'minEarnings': '¥680',
      'id': 8,
    },
    {
      'name': '中国平安',
      'code': '02318',
      'annualized': '+8.9%',
      'shares': '700',
      'minEarnings': '¥623',
      'id': 9,
    },
    {
      'name': '招商银行',
      'code': '03968',
      'annualized': '+10.7%',
      'shares': '900',
      'minEarnings': '¥963',
      'id': 10,
    },
  ];

  List<Map<String, dynamic>> transactionList = [
    {
      'stock': '腾讯控股',
      'direction': '买入',
      'quantity': '500',
      'unitPrice': '¥320.00',
      'amount': '¥160000',
      'profit': '+¥0',
      'time': '2025-10-15 09:30:22',
    },
    {
      'stock': '阿里巴巴',
      'direction': '卖出',
      'quantity': '300',
      'unitPrice': '¥85.50',
      'amount': '¥25650',
      'profit': '+¥3450',
      'time': '2025-10-12 14:22:15',
    },
    {
      'stock': '美团',
      'direction': '买入',
      'quantity': '200',
      'unitPrice': '¥185.20',
      'amount': '¥37040',
      'profit': '+¥0',
      'time': '2025-10-10 11:15:33',
    },
    {
      'stock': '小米集团',
      'direction': '卖出',
      'quantity': '1000',
      'unitPrice': '¥28.75',
      'amount': '¥28750',
      'profit': '+¥1250',
      'time': '2025-10-08 13:45:11',
    },
    {
      'stock': '比亚迪',
      'direction': '买入',
      'quantity': '100',
      'unitPrice': '¥245.80',
      'amount': '¥24580',
      'profit': '+¥0',
      'time': '2025-10-05 10:20:45',
    },
    {
      'stock': '宁德时代',
      'direction': '卖出',
      'quantity': '50',
      'unitPrice': '¥198.60',
      'amount': '¥9930',
      'profit': '¥-270',
      'time': '2025-10-01 15:10:37',
    },
    {
      'stock': '东方财富',
      'direction': '买入',
      'quantity': '800',
      'unitPrice': '¥16.40',
      'amount': '¥13120',
      'profit': '+¥0',
      'time': '2025-09-28 09:45:29',
    },
    {
      'stock': '五粮液',
      'direction': '卖出',
      'quantity': '200',
      'unitPrice': '¥175.30',
      'amount': '¥35060',
      'profit': '+¥2360',
      'time': '2025-09-25 14:30:18',
    },
  ];

  List<Map<String, dynamic>> performanceData = [
    {'month': '1月', 'value': 2.1},
    {'month': '2月', 'value': 2.8},
    {'month': '3月', 'value': 3.2},
    {'month': '4月', 'value': 2.9},
    {'month': '5月', 'value': 4.1},
    {'month': '6月', 'value': 3.8},
    {'month': '7月', 'value': 4.5},
    {'month': '8月', 'value': 5.2},
    {'month': '9月', 'value': 4.9},
    {'month': '10月', 'value': 5.8},
    {'month': '11月', 'value': 6.1},
    {'month': '12月', 'value': 6.4},
  ];

  int currentPage = 1;
  int totalPages = 2;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _initializeData() {
    print('HomeCtrl 初始化完成');
  }

  void tradeStock(Map<String, dynamic> stock) {
    print('交易股票: ${stock['name']}');
    // 这里可以添加交易逻辑
    showToast('正在处理 ${stock['name']} 的交易请求...');
  }

  void selectYear() {
    print('选择年份');
    // 这里可以添加年份选择逻辑
  }

  void selectMonth() {
    print('选择月份');
    // 这里可以添加月份选择逻辑
  }

  void resetFilters() {
    print('重置筛选条件');
    // 这里可以添加重置逻辑
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      update();
    }
  }

  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      update();
    }
  }

  void goToDeposit() {
    print('跳转到入金页面');
    FRoute.push(FRoute.newDeposit);
  }

  void goToWithdraw() {
    print('跳转到出金页面');
    showToast('出金功能敬请期待');
  }

  void goToExchange() {
    print('跳转到换汇页面');
    showToast('换汇功能敬请期待');
  }

  void goToEcommerce() {
    print('跳转到电商页面');
    FRoute.push(FRoute.ecommerce);
  }

  void goToDemo() {
    print('跳转到Demo页面');
    FRoute.push(FRoute.demo);
  }
}
