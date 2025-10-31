import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'deposit_ctrl.dart';

class DepositPage extends GetView<DepositCtrl> {
  const DepositPage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<DepositCtrl>(
      init: DepositCtrl(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            title: const Text('入金申请'),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF333333),
            elevation: 0,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildDepositForm(pW, controller),
                pW.Box(h: 16.h),
                _buildDepositList(pW, controller),
                pW.Box(h: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDepositForm(PublicWidget pW, DepositCtrl controller) {
    return Container(
      margin: EdgeInsets.all(16.w),
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
            '申请入金',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
          pW.Box(h: 20.h),
          _buildInputField(
            '入金金额',
            '请输入入金金额',
            controller.amountController,
            TextInputType.number,
          ),
          pW.Box(h: 16.h),
          _buildInputField(
            '备注',
            '请输入备注信息（可选）',
            controller.remarkController,
            TextInputType.text,
            maxLines: 3,
          ),
          pW.Box(h: 24.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: controller.submitDeposit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                '提交申请',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    String label,
    String hint,
    TextEditingController controller,
    TextInputType keyboardType, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF999999),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDepositList(PublicWidget pW, DepositCtrl controller) {
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
                '入金记录',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
              TextButton(
                onPressed: controller.refreshDepositList,
                child: Text(
                  '刷新',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF4CAF50),
                  ),
                ),
              ),
            ],
          ),
          pW.Box(h: 16.h),
          if (controller.depositList.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.all(40.w),
                child: Text(
                  '暂无入金记录',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF999999),
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.depositList.length,
              separatorBuilder: (context, index) => pW.Box(h: 12.h),
              itemBuilder: (context, index) {
                final deposit = controller.depositList[index];
                return _buildDepositItem(deposit);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildDepositItem(Map<String, dynamic> deposit) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '金额: ¥${deposit['amount']}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(deposit['status']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  deposit['status'],
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: _getStatusColor(deposit['status']),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          if (deposit['remark'] != null && deposit['remark'].isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              '备注: ${deposit['remark']}',
              style: TextStyle(fontSize: 14.sp, color: const Color(0xFF666666)),
            ),
          ],
          SizedBox(height: 8.h),
          Text(
            '申请时间: ${deposit['createTime']}',
            style: TextStyle(fontSize: 12.sp, color: const Color(0xFF999999)),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case '待审核':
        return const Color(0xFFFF9800);
      case '已通过':
        return const Color(0xFF4CAF50);
      case '已拒绝':
        return const Color(0xFFF44336);
      default:
        return const Color(0xFF666666);
    }
  }
}
