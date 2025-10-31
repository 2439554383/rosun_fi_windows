import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'profile_ctrl.dart';

class ProfilePage extends GetView<ProfileCtrl> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<ProfileCtrl>(
      init: ProfileCtrl(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(pW, controller),
                Expanded(child: _buildProfileContent(pW, controller)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(PublicWidget pW, ProfileCtrl controller) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: Colors.white,
      child: Row(
        children: [
          Text(
            '个人中心',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(
            onPressed: () => controller.logout(),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(PublicWidget pW, ProfileCtrl controller) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildUserInfo(pW, controller),
          pW.Box(h: 20.h),
          _buildMenuItems(pW, controller),
        ],
      ),
    );
  }

  Widget _buildUserInfo(PublicWidget pW, ProfileCtrl controller) {
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
          CircleAvatar(
            radius: 40.r,
            backgroundColor: Colors.blue[100],
            child: Icon(Icons.person, size: 40.sp, color: Colors.blue[700]),
          ),
          pW.Box(h: 16.h),
          Text(
            controller.userInfo['name'],
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          pW.Box(h: 8.h),
          Text(
            controller.userInfo['phone'],
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
          ),
          pW.Box(h: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem('总资产', controller.userInfo['totalAssets']),
              _buildInfoItem('今日收益', controller.userInfo['todayEarnings']),
              _buildInfoItem('总收益', controller.userInfo['totalEarnings']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    PublicWidget pW = PublicWidget();
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
        ),
        pW.Box(h: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: value.startsWith('+') ? Colors.green : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItems(PublicWidget pW, ProfileCtrl controller) {
    return Container(
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
        children: controller.menuItems.map((item) {
          return ListTile(
            leading: Icon(item['icon'], color: Colors.blue[700]),
            title: Text(item['title'], style: TextStyle(fontSize: 16.sp)),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: Colors.grey[400],
            ),
            onTap: () => controller.handleMenuTap(item['action']),
          );
        }).toList(),
      ),
    );
  }
}
