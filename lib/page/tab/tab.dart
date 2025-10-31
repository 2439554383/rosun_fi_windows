import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'tab_ctrl.dart';
import 'home/home_page.dart';
import 'market/market_page.dart';
import 'trade/trade_page.dart';
import 'message/message_page.dart';
import 'profile/profile_page.dart';

class TabPage extends GetView<TabCtrl> {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<TabCtrl>(
      init: TabCtrl(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _buildTopBar(pW, controller),
                Expanded(child: _buildTabContent(controller)),
                _buildBottomNavigation(pW, controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar(PublicWidget pW, TabCtrl controller) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: const Color(0xFFE9ECEF), width: 1),
        ),
      ),
      child: Row(
        children: [
          Text(
            'V8.0.7.8',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF6C757D),
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          Text(
            controller.getCurrentTabTitle(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => controller.logout(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(color: const Color(0xFFE9ECEF)),
              ),
              child: Text(
                '退出登录',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF6C757D),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(TabCtrl controller) {
    switch (controller.currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const MarketPage();
      case 2:
        return const TradePage();
      case 3:
        return const MessagePage();
      case 4:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }

  Widget _buildBottomNavigation(PublicWidget pW, TabCtrl controller) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: const Color(0xFFE9ECEF), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home, '首页', controller),
          _buildNavItem(1, Icons.trending_up, '行情', controller),
          _buildNavItem(2, Icons.swap_horiz, '交易', controller),
          _buildNavItem(3, Icons.notifications, '消息', controller),
          _buildNavItem(4, Icons.person, '个人中心', controller),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData icon,
    String label,
    TabCtrl controller,
  ) {
    PublicWidget pW = PublicWidget();
    final isSelected = controller.currentIndex == index;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.changeTab(index),
          borderRadius: BorderRadius.circular(25.r),
          splashColor: const Color(0xFF1976D2).withOpacity(0.1),
          highlightColor: const Color(0xFF1976D2).withOpacity(0.05),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? const Color(0xFF1976D2)
                      : const Color(0xFF6C757D),
                  size: 20.sp,
                ),
                pW.Box(h: 2.h),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: isSelected
                        ? const Color(0xFF1976D2)
                        : const Color(0xFF6C757D),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
