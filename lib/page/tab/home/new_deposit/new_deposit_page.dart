import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'new_deposit_ctrl.dart';
import 'deposit_application_page.dart';
import 'deposit_list_page.dart';

class NewDepositPage extends GetView<NewDepositCtrl> {
  const NewDepositPage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<NewDepositCtrl>(
      init: NewDepositCtrl(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            title: const Text('出入金流水'),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF333333),
            elevation: 0,
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Get.to(() => const DepositApplicationPage());
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // 标签页切换
              _buildTabBar(pW, controller),
              // 内容区域
              Expanded(
                child: controller.currentTabIndex == 0
                    ? const DepositListPage()
                    : const WithdrawListPage(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabBar(PublicWidget pW, NewDepositCtrl controller) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => controller.switchTab(0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: controller.currentTabIndex == 0
                          ? const Color(0xFF2196F3)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  '入金',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: controller.currentTabIndex == 0
                        ? const Color(0xFF2196F3)
                        : const Color(0xFF666666),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.switchTab(1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: controller.currentTabIndex == 1
                          ? const Color(0xFF2196F3)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  '出金',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: controller.currentTabIndex == 1
                        ? const Color(0xFF2196F3)
                        : const Color(0xFF666666),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 出金列表页面
class WithdrawListPage extends GetView<NewDepositCtrl> {
  const WithdrawListPage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<NewDepositCtrl>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.withdrawList.isEmpty) {
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
                  '暂无出金记录',
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
            controller.refreshWithdrawList();
          },
          child: ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: controller.withdrawList.length,
            itemBuilder: (context, index) {
              final withdraw = controller.withdrawList[index];
              return _buildWithdrawItem(pW, controller, withdraw);
            },
          ),
        );
      },
    );
  }

  Widget _buildWithdrawItem(
    PublicWidget pW,
    NewDepositCtrl controller,
    withdraw,
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
                '出金',
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
                      .getStatusColor(withdraw.auditStatus)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  withdraw.statusText,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: controller.getStatusColor(withdraw.auditStatus),
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
                '${withdraw.amount.toStringAsFixed(3)}${withdraw.currency ?? ''}',
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
                '出账金额',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF666666),
                ),
              ),
              Text(
                '${withdraw.amount.toStringAsFixed(3)}${withdraw.currency ?? ''}',
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
                '${withdraw.createTime?.substring(0, 10) ?? ''}',
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
          if (withdraw.auditStatus == 2 && withdraw.auditRemark != null) ...[
            pW.Box(h: 8.h),
            Text(
              '失败原因：${withdraw.auditRemark}',
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFFF44336)),
            ),
          ],
        ],
      ),
    );
  }
}
