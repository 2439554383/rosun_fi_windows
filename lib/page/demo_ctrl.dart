import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DemoCtrl extends GetxController {
  // 组件状态
  var isVisible = true.obs;
  var isLoading = false.obs;
  var selectedIndex = 0.obs;

  // 组件数据
  var title = 'Figma组件'.obs;
  var description = '这是一个根据Figma设计创建的组件'.obs;
  var buttonText = '确认'.obs;

  // 组件样式参数
  var backgroundColor = const Color(0xFFFFFFFF).obs;
  var primaryColor = const Color(0xFF2196F3).obs;
  var textColor = const Color(0xFF333333).obs;
  var borderRadius = 16.0.obs;
  var elevation = 4.0.obs;

  // 组件尺寸
  var width = 300.0.obs;
  var height = 400.0.obs;
  var iconSize = 80.0.obs;

  @override
  void onInit() {
    super.onInit();
    // 初始化组件参数
    _initializeComponent();
  }

  void _initializeComponent() {
    // 根据Android代码设置默认参数
    title.value = 'Tomato组件';
    description.value = '根据Android代码复刻的组件';
    width.value = 395.0; // 对应Android的395dp
    height.value = 444.0; // 对应Android的444dp
    backgroundColor.value = const Color(
      0xFFFAFAF5,
    ); // 对应Android的fillColor="#FAFAF5"
    textColor.value = const Color(0xFF333333);
    borderRadius.value = 24.0; // 对应Android的圆角半径24
    elevation.value = 0.0; // 无阴影，只有边框
    iconSize.value = 80.0;
  }

  // 更新组件参数
  void updateComponent({
    String? title,
    String? description,
    String? buttonText,
    Color? backgroundColor,
    Color? primaryColor,
    Color? textColor,
    double? borderRadius,
    double? elevation,
    double? width,
    double? height,
    double? iconSize,
  }) {
    if (title != null) this.title.value = title;
    if (description != null) this.description.value = description;
    if (buttonText != null) this.buttonText.value = buttonText;
    if (backgroundColor != null) this.backgroundColor.value = backgroundColor;
    if (primaryColor != null) this.primaryColor.value = primaryColor;
    if (textColor != null) this.textColor.value = textColor;
    if (borderRadius != null) this.borderRadius.value = borderRadius;
    if (elevation != null) this.elevation.value = elevation;
    if (width != null) this.width.value = width;
    if (height != null) this.height.value = height;
    if (iconSize != null) this.iconSize.value = iconSize;
  }

  // 切换可见性
  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  // 开始加载
  void startLoading() {
    isLoading.value = true;
  }

  // 停止加载
  void stopLoading() {
    isLoading.value = false;
  }

  // 选择项目
  void selectItem(int index) {
    selectedIndex.value = index;
  }

  // 重置组件
  void resetComponent() {
    _initializeComponent();
  }
}
