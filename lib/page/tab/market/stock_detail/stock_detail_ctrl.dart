import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../util/app_component.dart';

class StockDetailCtrl extends GetxController {
  Map<String, dynamic> stockData = {};
  bool isFavorite = false;
  String selectedTimeframe = '1D';

  List<Map<String, dynamic>> newsList = [
    {'title': '腾讯控股发布2024年第一季度财报，营收同比增长8.2%', 'source': '财经网', 'time': '2小时前'},
    {'title': '分析师看好腾讯游戏业务前景，目标价上调至350港元', 'source': '证券时报', 'time': '4小时前'},
    {'title': '腾讯云业务持续增长，市场份额进一步扩大', 'source': '科技日报', 'time': '6小时前'},
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
    // 从路由参数获取股票数据
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      stockData = arguments;
      print('股票详情页初始化: ${stockData['name']}');
    } else {
      // 默认数据
      stockData = {
        'name': '腾讯控股',
        'symbol': '00700',
        'price': '¥320.50',
        'change': '+2.15%',
      };
    }
    _loadStockDetails();
  }

  void _loadStockDetails() {
    // 模拟加载股票详细信息
    print('正在加载 ${stockData['name']} 的详细信息...');
    showToast('正在加载股票详情...');

    // 这里可以添加实际的API调用
    // 模拟数据加载完成
    Future.delayed(Duration(seconds: 1), () {
      update();
    });
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
    update();
    showToast(isFavorite ? '已添加到自选' : '已从自选移除');
  }

  void shareStock() {
    showToast('分享功能开发中...');
    // 这里可以实现分享功能
  }

  void selectTimeframe(String timeframe) {
    selectedTimeframe = timeframe;
    update();
    showToast('切换到${timeframe}图表');
    // 这里可以重新加载对应时间段的图表数据
  }

  void loadMoreNews() {
    showToast('加载更多资讯...');
    // 这里可以加载更多新闻数据
  }

  void buyStock() {
    showToast('买入功能开发中...');
    // 这里可以实现买入逻辑
    _showTradingDialog('买入');
  }

  void sellStock() {
    showToast('卖出功能开发中...');
    // 这里可以实现卖出逻辑
    _showTradingDialog('卖出');
  }

  void _showTradingDialog(String action) {
    Get.dialog(
      AlertDialog(
        title: Text('$action 股票'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('股票: ${stockData['name']}'),
            SizedBox(height: 10),
            Text('当前价格: ${stockData['price']}'),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: '数量',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('取消')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              showToast('$action 订单已提交');
            },
            child: Text('确认'),
          ),
        ],
      ),
    );
  }
}
