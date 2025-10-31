import 'package:get/get.dart';
import '../../../util/app_component.dart';
import '../../../util/f_route.dart';

class MarketCtrl extends GetxController {
  List<Map<String, dynamic>> marketList = [
    {'name': '腾讯控股', 'symbol': '00700', 'price': '¥320.50', 'change': '+2.15%'},
    {'name': '阿里巴巴', 'symbol': '09988', 'price': '¥85.20', 'change': '-1.25%'},
    {'name': '美团', 'symbol': '03690', 'price': '¥185.80', 'change': '+3.45%'},
    {'name': '小米集团', 'symbol': '01810', 'price': '¥28.90', 'change': '+1.85%'},
    {'name': '比亚迪', 'symbol': '01211', 'price': '¥245.60', 'change': '+4.20%'},
    {
      'name': '宁德时代',
      'symbol': '300750',
      'price': '¥198.30',
      'change': '-0.85%',
    },
    {'name': '东方财富', 'symbol': '300059', 'price': '¥16.45', 'change': '+2.65%'},
    {'name': '五粮液', 'symbol': '000858', 'price': '¥175.20', 'change': '+1.95%'},
    {'name': '中国平安', 'symbol': '02318', 'price': '¥45.80', 'change': '-0.65%'},
    {'name': '招商银行', 'symbol': '03968', 'price': '¥38.90', 'change': '+1.25%'},
  ];

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
    print('MarketCtrl 初始化完成');
  }

  void selectStock(Map<String, dynamic> stock) {
    FRoute.push(FRoute.stockDetail, arguments: stock);
    print('选择股票: ${stock['name']}');
    // showToast('正在加载 ${stock['name']} 的详细信息...');
  }
}
