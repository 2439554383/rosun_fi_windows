import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/app_component.dart';

class ProfileCtrl extends GetxController {
  Map<String, dynamic> userInfo = {
    'name': '张三',
    'phone': '138****8888',
    'totalAssets': '¥10,250,000',
    'todayEarnings': '+¥45,600',
    'totalEarnings': '+¥1,230,000',
  };

  List<Map<String, dynamic>> menuItems = [
    {'title': '账户设置', 'icon': Icons.settings, 'action': 'account_settings'},
    {'title': '安全设置', 'icon': Icons.security, 'action': 'security_settings'},
    {'title': '交易记录', 'icon': Icons.history, 'action': 'trade_history'},
    {
      'title': '资金明细',
      'icon': Icons.account_balance_wallet,
      'action': 'fund_details',
    },
    {'title': '帮助中心', 'icon': Icons.help, 'action': 'help_center'},
    {'title': '关于我们', 'icon': Icons.info, 'action': 'about_us'},
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _initializeData() {
    print('ProfileCtrl 初始化完成');
  }

  void handleMenuTap(String action) {
    switch (action) {
      case 'account_settings':
        showToast('跳转到账户设置页面');
        break;
      case 'security_settings':
        showToast('跳转到安全设置页面');
        break;
      case 'trade_history':
        showToast('跳转到交易记录页面');
        break;
      case 'fund_details':
        showToast('跳转到资金明细页面');
        break;
      case 'help_center':
        showToast('跳转到帮助中心页面');
        break;
      case 'about_us':
        showToast('跳转到关于我们页面');
        break;
    }
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: Text('确认退出'),
        content: Text('您确定要退出登录吗？'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('取消')),
          TextButton(
            onPressed: () {
              Get.back();
              showToast('已退出登录');
            },
            child: Text('确认'),
          ),
        ],
      ),
    );
  }
}
