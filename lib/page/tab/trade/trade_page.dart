import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'trade_ctrl.dart';

class TradePage extends GetView<TradeCtrl> {
  const TradePage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<TradeCtrl>(
      init: TradeCtrl(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(pW),
                Expanded(child: _buildTradeContent(pW, controller)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(PublicWidget pW) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: Colors.white,
      child: Row(
        children: [
          Text(
            '交易',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.history)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
    );
  }

  Widget _buildTradeContent(PublicWidget pW, TradeCtrl controller) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildTradeForm(pW, controller),
          pW.Box(h: 20.h),
          _buildTradeHistory(pW, controller),
        ],
      ),
    );
  }

  Widget _buildTradeForm(PublicWidget pW, TradeCtrl controller) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '交易下单',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          pW.Box(h: 16.h),
          _buildStockSelector(pW, controller),
          pW.Box(h: 16.h),
          _buildTradeTypeSelector(pW, controller),
          pW.Box(h: 16.h),
          _buildQuantityInput(pW, controller),
          pW.Box(h: 16.h),
          _buildPriceInput(pW, controller),
          pW.Box(h: 20.h),
          _buildTradeButtons(pW, controller),
        ],
      ),
    );
  }

  Widget _buildStockSelector(PublicWidget pW, TradeCtrl controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('选择股票'),
        pW.Box(h: 8.h),
        DropdownButtonFormField<String>(
          value: controller.selectedStock,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
          ),
          items: controller.stockList.map<DropdownMenuItem<String>>((stock) {
            return DropdownMenuItem<String>(
              value: stock['symbol'],
              child: Text('${stock['name']} (${stock['symbol']})'),
            );
          }).toList(),
          onChanged: (value) => controller.selectStock(value!),
        ),
      ],
    );
  }

  Widget _buildTradeTypeSelector(PublicWidget pW, TradeCtrl controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('交易类型'),
        pW.Box(h: 8.h),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: Text('买入'),
                value: 'buy',
                groupValue: controller.tradeType,
                onChanged: (value) => controller.setTradeType(value!),
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text('卖出'),
                value: 'sell',
                groupValue: controller.tradeType,
                onChanged: (value) => controller.setTradeType(value!),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityInput(PublicWidget pW, TradeCtrl controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('数量'),
        pW.Box(h: 8.h),
        TextField(
          controller: controller.quantityController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: '请输入数量',
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceInput(PublicWidget pW, TradeCtrl controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('价格'),
        pW.Box(h: 8.h),
        TextField(
          controller: controller.priceController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: '请输入价格',
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTradeButtons(PublicWidget pW, TradeCtrl controller) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => controller.submitTrade(),
            style: ElevatedButton.styleFrom(
              backgroundColor: controller.tradeType == 'buy'
                  ? Colors.green
                  : Colors.red,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            child: Text(
              controller.tradeType == 'buy' ? '买入' : '卖出',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        pW.Box(w: 12.w),
        Expanded(
          child: ElevatedButton(
            onPressed: () => controller.resetForm(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black87,
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            child: Text('重置'),
          ),
        ),
      ],
    );
  }

  Widget _buildTradeHistory(PublicWidget pW, TradeCtrl controller) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                '交易记录',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.tradeHistory.length,
                itemBuilder: (context, index) {
                  final trade = controller.tradeHistory[index];
                  return ListTile(
                    leading: Icon(
                      trade['type'] == 'buy'
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: trade['type'] == 'buy' ? Colors.green : Colors.red,
                    ),
                    title: Text(trade['stock']),
                    subtitle: Text('${trade['quantity']}股 @ ${trade['price']}'),
                    trailing: Text(
                      trade['status'],
                      style: TextStyle(
                        color: trade['status'] == '已完成'
                            ? Colors.green
                            : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
