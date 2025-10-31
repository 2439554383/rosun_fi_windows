import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'new_deposit_ctrl.dart';
import '../new_deposit_model.dart';

class DepositListPage extends GetView<NewDepositCtrl> {
  const DepositListPage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<NewDepositCtrl>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.depositList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 64.w,
                  color: const Color(0xFF999999),
                ),
                pW.Box(h: 16.h),
                Text(
                  '暂无入金记录',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF999999),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.refreshDepositList();
          },
          child: ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: controller.depositList.length,
            itemBuilder: (context, index) {
              final deposit = controller.depositList[index];
              return _buildDepositItem(pW, controller, deposit);
            },
          ),
        );
      },
    );
  }

  Widget _buildDepositItem(
    PublicWidget pW,
    NewDepositCtrl controller,
    NewDepositRequest deposit,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
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
                deposit.depositMethodText,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: controller
                      .getStatusColor(deposit.auditStatus)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  deposit.statusText,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: controller.getStatusColor(deposit.auditStatus),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          pW.Box(h: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '到账数量',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF666666),
                ),
              ),
              Text(
                '${deposit.expectedArrival?.toStringAsFixed(3) ?? deposit.amount.toStringAsFixed(3)}${deposit.currency ?? ''}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF333333),
                ),
              ),
            ],
          ),
          pW.Box(h: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '入账金额',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF666666),
                ),
              ),
              Text(
                '${deposit.amount.toStringAsFixed(3)}${deposit.currency ?? ''}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF333333),
                ),
              ),
            ],
          ),
          pW.Box(h: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${deposit.createTime?.substring(0, 10) ?? ''}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF999999),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: Color(0xFF999999),
              ),
            ],
          ),
          if (deposit.auditStatus == 2 && deposit.auditRemark != null) ...[
            pW.Box(h: 8.h),
            Text(
              '失败原因：${deposit.auditRemark}',
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFFF44336)),
            ),
          ],
        ],
      ),
    );
  }
}
