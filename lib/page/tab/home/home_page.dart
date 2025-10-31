import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'home_ctrl.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter/material.dart';

class HomePage extends GetView<HomeCtrl> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<HomeCtrl>(
      init: HomeCtrl(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildAccountOverview(pW),
                pW.Box(h: 16.h),
                _buildStatisticalData(pW, controller),
                pW.Box(h: 16.h),
                _buildFinancialOperations(pW, controller),
                pW.Box(h: 16.h),
                _buildStockPool(pW, controller),
                pW.Box(h: 16.h),
                _buildHistoricalPerformance(pW, controller),
                pW.Box(h: 16.h),
                _buildTransactionRecords(pW, controller),
                pW.Box(h: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAccountOverview(PublicWidget pW) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '可用购买力',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF666666),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  pW.Box(h: 8.h),
                  Text(
                    '¥ 1,250,000',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1976D2),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          pW.Box(w: 12.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '未平仓总金额',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF666666),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  pW.Box(h: 8.h),
                  Text(
                    '¥ 8,760,000',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1976D2),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticalData(PublicWidget pW, HomeCtrl controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '统计数据',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
          pW.Box(h: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  '今日收益',
                  '+ ¥ 45,600',
                  const Color(0xFF4CAF50),
                  Icons.trending_up,
                ),
              ),
              pW.Box(w: 12.w),
              Expanded(
                child: _buildStatCard(
                  '近30日收益',
                  '+ ¥ 1,230,000',
                  const Color(0xFF4CAF50),
                  Icons.trending_up,
                ),
              ),
            ],
          ),
          pW.Box(h: 12.h),
          _buildStatCard(
            '当月收益',
            '- ¥ 89,000',
            const Color(0xFFF44336),
            Icons.trending_down,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 14.sp),
              SizedBox(width: 6.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF666666),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: color,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialOperations(PublicWidget pW, HomeCtrl controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '资金操作',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
          pW.Box(h: 16.h),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 6,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 7 / 3,
            children: [
              _buildFinancialCard(
                '入金',
                Icons.account_balance_wallet,
                const Color(0xFF4CAF50),
                () => controller.goToDeposit(),
              ),
              _buildFinancialCard(
                '出金',
                Icons.money_off,
                const Color(0xFFF44336),
                () => controller.goToWithdraw(),
              ),
              _buildFinancialCard(
                '换汇',
                Icons.swap_horiz,
                const Color(0xFF2196F3),
                () => controller.goToExchange(),
              ),
              _buildFinancialCard(
                '电商',
                Icons.shopping_cart,
                const Color(0xFFFF9800),
                () => controller.goToEcommerce(),
              ),
              _buildFinancialCard(
                'Demo',
                Icons.code,
                const Color(0xFF9C27B0),
                () => controller.goToDemo(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @Preview(
    name: 'Simple Widget',
    size: Size(401, 300), // <-- 2. Pass size
  )
  Widget _buildFinancialCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: color.withOpacity(0.2), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32.sp),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockPool(PublicWidget pW, HomeCtrl controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 8,
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
                '券池',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
              Container(
                width: 180.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFE9ECEF), width: 1),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '搜索股票...',
                    hintStyle: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF6C757D),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 16.sp,
                      color: const Color(0xFF6C757D),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
          pW.Box(h: 16.h),
          _buildStockTable(controller),
        ],
      ),
    );
  }

  Widget _buildStockTable(HomeCtrl controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20.w,
        headingRowHeight: 40.h,
        dataRowHeight: 48.h,
        headingTextStyle: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF333333),
        ),
        dataTextStyle: TextStyle(
          fontSize: 12.sp,
          color: const Color(0xFF666666),
        ),
        columns: [
          DataColumn(label: Text('股票')),
          DataColumn(label: Text('代码')),
          DataColumn(label: Text('年化')),
          DataColumn(label: Text('股数可用')),
          DataColumn(label: Text('最少收益')),
          DataColumn(label: Text('操作')),
        ],
        rows: controller.stockList.map((stock) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  stock['name'],
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              DataCell(Text(stock['code'])),
              DataCell(
                Text(
                  stock['annualized'],
                  style: TextStyle(
                    color: const Color(0xFF4CAF50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(Text(stock['shares'])),
              DataCell(Text(stock['minEarnings'])),
              DataCell(
                Container(
                  height: 28.h,
                  child: ElevatedButton(
                    onPressed: () => controller.tradeStock(stock),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976D2),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h,
                      ),
                      minimumSize: Size(60.w, 28.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    child: Text('交易', style: TextStyle(fontSize: 11.sp)),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHistoricalPerformance(PublicWidget pW, HomeCtrl controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '历史业绩',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
          pW.Box(h: 16.h),
          Container(height: 180.h, child: _buildPerformanceChart(controller)),
        ],
      ),
    );
  }

  Widget _buildPerformanceChart(HomeCtrl controller) {
    return CustomPaint(
      size: Size.infinite,
      painter: PerformanceChartPainter(controller.performanceData),
    );
  }

  Widget _buildTransactionRecords(PublicWidget pW, HomeCtrl controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 8,
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
                '历史交易记录',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
              Row(
                children: [
                  _buildFilterButton('选择年份', () => controller.selectYear()),
                  pW.Box(w: 8.w),
                  _buildFilterButton('选择月份', () => controller.selectMonth()),
                  pW.Box(w: 8.w),
                  _buildFilterButton('重置', () => controller.resetFilters()),
                ],
              ),
            ],
          ),
          pW.Box(h: 16.h),
          _buildTransactionTable(controller),
          pW.Box(h: 16.h),
          _buildPagination(controller),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, VoidCallback onPressed) {
    return Container(
      height: 28.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF8F9FA),
          foregroundColor: const Color(0xFF6C757D),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          minimumSize: Size(80.w, 28.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
            side: BorderSide(color: const Color(0xFFE9ECEF)),
          ),
        ),
        child: Text(text, style: TextStyle(fontSize: 12.sp)),
      ),
    );
  }

  Widget _buildTransactionTable(HomeCtrl controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16.w,
        headingRowHeight: 40.h,
        dataRowHeight: 48.h,
        headingTextStyle: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF333333),
        ),
        dataTextStyle: TextStyle(
          fontSize: 12.sp,
          color: const Color(0xFF666666),
        ),
        columns: [
          DataColumn(label: Text('股票')),
          DataColumn(label: Text('买卖方向')),
          DataColumn(label: Text('数量')),
          DataColumn(label: Text('单价')),
          DataColumn(label: Text('金额')),
          DataColumn(label: Text('收益')),
          DataColumn(label: Text('交易时间')),
        ],
        rows: controller.transactionList.map((transaction) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  transaction['stock'],
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              DataCell(
                Row(
                  children: [
                    Icon(
                      transaction['direction'] == '买入'
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: transaction['direction'] == '买入'
                          ? const Color(0xFFF44336)
                          : const Color(0xFF4CAF50),
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(transaction['direction']),
                  ],
                ),
              ),
              DataCell(Text(transaction['quantity'])),
              DataCell(Text(transaction['unitPrice'])),
              DataCell(Text(transaction['amount'])),
              DataCell(
                Text(
                  transaction['profit'],
                  style: TextStyle(
                    color: transaction['profit'].startsWith('+')
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFF44336),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(Text(transaction['time'])),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPagination(HomeCtrl controller) {
    PublicWidget pW = PublicWidget();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '共${controller.transactionList.length}条记录',
          style: TextStyle(fontSize: 12.sp, color: const Color(0xFF666666)),
        ),
        Row(
          children: [
            _buildPaginationButton(
              '<上一页',
              controller.currentPage > 1
                  ? () => controller.previousPage()
                  : null,
            ),
            pW.Box(w: 8.w),
            Text(
              '第${controller.currentPage}页,共${controller.totalPages}页',
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF666666)),
            ),
            pW.Box(w: 8.w),
            _buildPaginationButton(
              '下一页>',
              controller.currentPage < controller.totalPages
                  ? () => controller.nextPage()
                  : null,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaginationButton(String text, VoidCallback? onPressed) {
    return Container(
      height: 28.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed != null
              ? const Color(0xFFF8F9FA)
              : const Color(0xFFE9ECEF),
          foregroundColor: onPressed != null
              ? const Color(0xFF6C757D)
              : const Color(0xFFADB5BD),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          minimumSize: Size(60.w, 28.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
            side: BorderSide(color: const Color(0xFFE9ECEF)),
          ),
        ),
        child: Text(text, style: TextStyle(fontSize: 12.sp)),
      ),
    );
  }
}

class PerformanceChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  PerformanceChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.blue.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final stepX = size.width / (data.length - 1);
    final maxValue = 7.0;
    final minValue = 0.0;
    final range = maxValue - minValue;

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y =
          size.height - ((data[i]['value'] - minValue) / range) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // 绘制数据点
    final pointPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y =
          size.height - ((data[i]['value'] - minValue) / range) * size.height;
      canvas.drawCircle(Offset(x, y), 3, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
