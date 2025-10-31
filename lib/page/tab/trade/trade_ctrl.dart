import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/app_component.dart';

class TradeCtrl extends GetxController {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String selectedStock = '00700';
  String tradeType = 'buy';

  List<Map<String, dynamic>> stockList = [
    {'name': '腾讯控股', 'symbol': '00700'},
    {'name': '阿里巴巴', 'symbol': '09988'},
    {'name': '美团', 'symbol': '03690'},
    {'name': '小米集团', 'symbol': '01810'},
    {'name': '比亚迪', 'symbol': '01211'},
  ];

  List<Map<String, dynamic>> tradeHistory = [
    {
      'stock': '腾讯控股',
      'type': 'buy',
      'quantity': '500',
      'price': '¥320.00',
      'status': '已完成',
    },
    {
      'stock': '阿里巴巴',
      'type': 'sell',
      'quantity': '300',
      'price': '¥85.50',
      'status': '已完成',
    },
    {
      'stock': '美团',
      'type': 'buy',
      'quantity': '200',
      'price': '¥185.20',
      'status': '处理中',
    },
    {
      'stock': '小米集团',
      'type': 'sell',
      'quantity': '1000',
      'price': '¥28.75',
      'status': '已完成',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  @override
  void onClose() {
    quantityController.dispose();
    priceController.dispose();
    super.onClose();
  }

  void _initializeData() {
    print('TradeCtrl 初始化完成');
  }

  void selectStock(String symbol) {
    selectedStock = symbol;
    update();
  }

  void setTradeType(String type) {
    tradeType = type;
    update();
  }

  void submitTrade() {
    if (quantityController.text.isEmpty || priceController.text.isEmpty) {
      showToast('请填写完整的交易信息');
      return;
    }

    final selectedStockName = stockList.firstWhere(
      (stock) => stock['symbol'] == selectedStock,
    )['name'];

    showToast(
      '${tradeType == 'buy' ? '买入' : '卖出'} ${selectedStockName} ${quantityController.text}股 @ ${priceController.text}',
    );

    // 添加到交易记录
    tradeHistory.insert(0, {
      'stock': selectedStockName,
      'type': tradeType,
      'quantity': quantityController.text,
      'price': '¥${priceController.text}',
      'status': '处理中',
    });

    resetForm();
    update();
  }

  void resetForm() {
    quantityController.clear();
    priceController.clear();
    tradeType = 'buy';
    selectedStock = '00700';
    update();
  }
}
