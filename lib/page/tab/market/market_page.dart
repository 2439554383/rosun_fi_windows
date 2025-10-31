import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/util/f_route.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'market_ctrl.dart';

class MarketPage extends GetView<MarketCtrl> {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<MarketCtrl>(
      init: MarketCtrl(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(pW),
                Expanded(child: _buildMarketContent(pW, controller)),
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
            '行情',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
        ],
      ),
    );
  }

  Widget _buildMarketContent(PublicWidget pW, MarketCtrl controller) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildMarketOverview(pW, controller),
          pW.Box(h: 20.h),
          _buildMarketList(pW, controller),
        ],
      ),
    );
  }

  Widget _buildMarketOverview(PublicWidget pW, MarketCtrl controller) {
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
        children: [
          Text(
            '市场概览',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          pW.Box(h: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMarketItem('上证指数', '3,245.67', '+1.23%', Colors.green),
              _buildMarketItem('深证成指', '10,856.32', '-0.45%', Colors.red),
              _buildMarketItem('创业板指', '2,234.56', '+2.15%', Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMarketItem(
    String name,
    String value,
    String change,
    Color color,
  ) {
    PublicWidget pW = PublicWidget();
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
        ),
        pW.Box(h: 4.h),
        Text(
          value,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        Text(
          change,
          style: TextStyle(
            fontSize: 12.sp,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMarketList(PublicWidget pW, MarketCtrl controller) {
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
        child: ListView.builder(
          itemCount: controller.marketList.length,
          itemBuilder: (context, index) {
            final item = controller.marketList[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Text(
                  item['symbol'].substring(0, 1),
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                item['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['symbol']),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item['price'],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    item['change'],
                    style: TextStyle(
                      color: item['change'].startsWith('+')
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () => controller.selectStock(item),
            );
          },
        ),
      ),
    );
  }
}
