import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';

class DepositSuccessPage extends StatelessWidget {
  const DepositSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    final arguments = Get.arguments as Map<String, dynamic>?;

    final amount = arguments?['amount'] ?? 0.0;
    final bank = arguments?['bank'] ?? '';
    final serviceCharge = arguments?['serviceCharge'] ?? 0.0;
    final currency = arguments?['currency'] ?? 'HKD';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('入金'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF333333),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            pW.Box(h: 40.h),

            // 成功图标
            _buildSuccessIcon(pW),
            pW.Box(h: 24.h),

            // 成功信息
            _buildSuccessMessage(pW),
            pW.Box(h: 32.h),

            // 入金信息
            _buildDepositInfo(pW, amount, bank, serviceCharge, currency),
            pW.Box(h: 40.h),

            // 完成按钮
            _buildCompleteButton(pW),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessIcon(PublicWidget pW) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 主圆形图标
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 40),
        ),
        // 装饰性小图标
        ...List.generate(4, (index) {
          final angle = (index * 90.0) * (3.14159 / 180);
          final radius = 50.w;
          final x = radius * (1 + 0.3 * (angle / (3.14159 / 2)));
          final y = radius * (1 + 0.3 * (angle / (3.14159 / 2)));

          return Positioned(
            left: x,
            top: y,
            child: Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(
                color: Color(0xFF2196F3),
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSuccessMessage(PublicWidget pW) {
    return Column(
      children: [
        Text(
          '入金申请提交成功',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
        pW.Box(h: 8.h),
        Text(
          '审核预计需要3-5个工作日,请耐心等待',
          style: TextStyle(fontSize: 14.sp, color: const Color(0xFF666666)),
        ),
      ],
    );
  }

  Widget _buildDepositInfo(
    PublicWidget pW,
    double amount,
    String bank,
    double serviceCharge,
    String currency,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '入金信息',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
          pW.Box(h: 16.h),

          _buildInfoRow('入金金额', '${amount.toStringAsFixed(0)} $currency'),
          pW.Box(h: 12.h),
          _buildInfoRow('入金银行', bank),
          pW.Box(h: 12.h),
          _buildInfoRow(
            '预计手续费',
            '${serviceCharge.toStringAsFixed(0)} $currency',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, color: const Color(0xFF666666)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  Widget _buildCompleteButton(PublicWidget pW) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          Get.offAllNamed('/newDeposit');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2196F3),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(
          '完成',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
