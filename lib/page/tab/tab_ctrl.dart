import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../util/app_component.dart';

class TabCtrl extends GetxController {
  int currentIndex = 0;

  List<String> tabTitles = ['首页', '行情', '交易', '消息', '个人中心'];

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
    print('TabCtrl 初始化完成');
  }

  void changeTab(int index) {
    if (index != currentIndex) {
      currentIndex = index;
      update();
    }
  }

  String getCurrentTabTitle() {
    return tabTitles[currentIndex];
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
