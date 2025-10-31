import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'new_deposit_ctrl.dart';

class DepositApplicationPage extends GetView<NewDepositCtrl> {
  const DepositApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<NewDepositCtrl>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            title: const Text('电汇入金'),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF333333),
            elevation: 0,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 入金信息完善
                _buildDepositInfoSection(pW, controller),
                pW.Box(h: 20.h),
                // 上传打款凭证
                _buildUploadSection(pW, controller),
                pW.Box(h: 20.h),
                // 提交按钮
                _buildSubmitButton(pW, controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDepositInfoSection(PublicWidget pW, NewDepositCtrl controller) {
    return Container(
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
            '入金信息完善',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
          pW.Box(h: 20.h),

          // 入金银行显示（固定）
          _buildFixedBankInfo(pW, controller),
          pW.Box(h: 16.h),

          // 入金金额输入
          _buildAmountInput(pW, controller),
          pW.Box(h: 8.h),

          // 手续费显示
          _buildServiceFee(pW, controller),
        ],
      ),
    );
  }

  Widget _buildFixedBankInfo(PublicWidget pW, NewDepositCtrl controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '入金银行',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        pW.Box(h: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.account_balance,
                size: 20.w,
                color: const Color(0xFF2196F3),
              ),
              SizedBox(width: 12.w),
              Text(
                '【中国香港】花旗银行(4546)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF333333),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInput(PublicWidget pW, NewDepositCtrl controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '入金金额',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        pW.Box(h: 8.h),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.amountController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.getServiceCharge();
                },
                decoration: InputDecoration(
                  hintText: '请输入已打款金额',
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
                    borderSide: const BorderSide(
                      color: Color(0xFF2196F3),
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
            pW.Box(w: 12.w),
            Text(
              controller.selectedCurrency,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF333333),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceFee(PublicWidget pW, NewDepositCtrl controller) {
    return Row(
      children: [
        Text(
          '手续费 ',
          style: TextStyle(fontSize: 14.sp, color: const Color(0xFF333333)),
        ),
        Text(
          '${(controller.serviceChargeInfo?.serviceCharge ?? 0.0).toStringAsFixed(0)}${controller.selectedCurrency}',
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFFF44336),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadSection(PublicWidget pW, NewDepositCtrl controller) {
    return Container(
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
            '上传打款凭证',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
          pW.Box(h: 20.h),

          // 凭证显示区域（固定）
          Container(
            width: double.infinity,
            height: 120.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              border: Border.all(
                color: const Color(0xFFE0E0E0),
                style: BorderStyle.solid,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt, size: 32.w, color: const Color(0xFF4CAF50)),
                pW.Box(h: 8.h),
                Text(
                  '凭证已自动生成',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF4CAF50),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                pW.Box(h: 4.h),
                Text(
                  'transfer_proof_${DateTime.now().millisecondsSinceEpoch}.jpg',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          pW.Box(h: 16.h),

          // 上传要求
          Text(
            '其中需包含:',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF333333),
            ),
          ),
          pW.Box(h: 8.h),
          _buildRequirementItem('打款人全名'),
          _buildRequirementItem('银行账户详情, 含银行名称和银行卡号'),
          _buildRequirementItem('打款金额及币种'),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Container(
            width: 4.w,
            height: 4.w,
            decoration: const BoxDecoration(
              color: Color(0xFF666666),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14.sp, color: const Color(0xFF666666)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(PublicWidget pW, NewDepositCtrl controller) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: controller.isSubmitting ? null : controller.submitDeposit,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2196F3),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: controller.isSubmitting
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                '提交',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
