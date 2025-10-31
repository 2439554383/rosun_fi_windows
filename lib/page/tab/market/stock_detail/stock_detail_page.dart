import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'package:rosun_fi_windows/util/app_component.dart';
import 'stock_detail_ctrl.dart';

class StockDetailPage extends GetView<StockDetailCtrl> {
  final PublicWidget pW = PublicWidget();
  StockDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockDetailCtrl>(
      init: StockDetailCtrl(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(pW, controller),
                Expanded(child: _buildDetailContent(pW, controller)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(PublicWidget pW, StockDetailCtrl controller) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            onPressed: safeBack,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.stockData['name'] ?? '股票详情',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.stockData['symbol'] ?? '',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => controller.toggleFavorite(),
            icon: Icon(
              controller.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: controller.isFavorite ? Colors.red : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () => controller.shareStock(),
            icon: Icon(Icons.share),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailContent(PublicWidget pW, StockDetailCtrl controller) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPriceSection(pW, controller),
          pW.Box(h: 16.h),
          _buildChartSection(pW, controller),
          pW.Box(h: 16.h),
          _buildInfoSection(pW, controller),
          pW.Box(h: 16.h),
          _buildNewsSection(pW, controller),
          pW.Box(h: 16.h),
          _buildActionButtons(pW, controller),
          pW.Box(h: 20.h),
        ],
      ),
    );
  }

  Widget _buildPriceSection(PublicWidget pW, StockDetailCtrl controller) {
    final stockData = controller.stockData;
    final isPositive = stockData['change']?.startsWith('+') ?? false;
    final changeColor = isPositive ? Colors.green : Colors.red;

    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '当前价格',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
              ),
              Text(
                '实时数据',
                style: TextStyle(fontSize: 12.sp, color: Colors.green),
              ),
            ],
          ),
          pW.Box(h: 8.h),
          Row(
            children: [
              Text(
                stockData['price'] ?? '¥0.00',
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
              ),
              pW.Box(w: 16.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: changeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  stockData['change'] ?? '+0.00%',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: changeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          pW.Box(h: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPriceItem('最高', '¥325.80'),
              _buildPriceItem('最低', '¥318.20'),
              _buildPriceItem('成交量', '1.2M'),
              _buildPriceItem('市值', '3.2T'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
        ),
        pW.Box(h: 4.h),
        Text(
          value,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildChartSection(PublicWidget pW, StockDetailCtrl controller) {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'K线图',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  _buildChartButton('日K', controller.selectedTimeframe == '1D'),
                  pW.Box(w: 8.w),
                  _buildChartButton('周K', controller.selectedTimeframe == '1W'),
                  pW.Box(w: 8.w),
                  _buildChartButton('月K', controller.selectedTimeframe == '1M'),
                ],
              ),
            ],
          ),
          pW.Box(h: 16.h),
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.show_chart, size: 48.sp, color: Colors.grey[400]),
                  pW.Box(h: 8.h),
                  Text(
                    '图表数据加载中...',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.selectTimeframe(text),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(PublicWidget pW, StockDetailCtrl controller) {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
            '基本信息',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          pW.Box(h: 16.h),
          _buildInfoRow('所属行业', '科技'),
          _buildInfoRow('上市时间', '2004-06-16'),
          _buildInfoRow('发行价格', '¥3.70'),
          _buildInfoRow('总股本', '95.5亿股'),
          _buildInfoRow('流通股本', '95.5亿股'),
          _buildInfoRow('市盈率', '12.5'),
          _buildInfoRow('市净率', '2.8'),
          _buildInfoRow('52周最高', '¥425.80'),
          _buildInfoRow('52周最低', '¥285.20'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsSection(PublicWidget pW, StockDetailCtrl controller) {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '相关资讯',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => controller.loadMoreNews(),
                child: Text('更多'),
              ),
            ],
          ),
          pW.Box(h: 16.h),
          ...controller.newsList.map((news) => _buildNewsItem(news, pW)),
        ],
      ),
    );
  }

  Widget _buildNewsItem(Map<String, dynamic> news, PublicWidget pW) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            news['title'],
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          pW.Box(h: 4.h),
          Row(
            children: [
              Text(
                news['source'],
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
              pW.Box(w: 8.w),
              Text(
                news['time'],
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(PublicWidget pW, StockDetailCtrl controller) {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => controller.buyStock(),
              icon: Icon(Icons.trending_up),
              label: Text('买入'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),
          pW.Box(w: 12.w),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => controller.sellStock(),
              icon: Icon(Icons.trending_down),
              label: Text('卖出'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
