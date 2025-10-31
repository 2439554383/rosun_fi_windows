import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'demo_ctrl.dart';

class DemoPage extends GetView<DemoCtrl> {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<DemoCtrl>(
      init: DemoCtrl(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            title: const Text('Figma组件Demo'),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF333333),
            elevation: 0,
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => _showSettingsDialog(controller),
              ),
            ],
          ),
          body: Center(
            child: Obx(
              () => controller.isVisible.value
                  ? _buildFigmaComponent(pW, controller)
                  : const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFigmaComponent(PublicWidget pW, DemoCtrl controller) {
    return Obx(
      () => Container(
        width: 395.w, // 固定宽度，对应Android的395dp
        height: 444.h, // 固定高度，对应Android的444dp
        margin: EdgeInsets.only(
          left: 96.w, // 对应Android的layout_marginLeft="96dp"
          right: 949.w, // 对应Android的layout_marginRight="949dp"
          top: 301.h, // 对应Android的layout_marginTop="301dp"
        ),
        child: ClipPath(
          clipper: _TomatoClipper(), // 自定义裁剪路径
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAF5), // 对应Android的fillColor="#FAFAF5"
              border: Border.all(
                color: const Color(
                  0xFFE6E6E6,
                ), // 对应Android的strokeColor="#E6E6E6"
                width: 4.w, // 对应Android的strokeWidth="4"
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 图标区域
                Container(
                  width: controller.iconSize.value.w,
                  height: controller.iconSize.value.w,
                  decoration: BoxDecoration(
                    color: controller.primaryColor.value.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.star,
                    size: (controller.iconSize.value * 0.5).w,
                    color: controller.primaryColor.value,
                  ),
                ),
                pW.Box(h: 24.h),

                // 标题
                Text(
                  controller.title.value,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: controller.textColor.value,
                  ),
                ),
                pW.Box(h: 12.h),

                // 描述
                Text(
                  controller.description.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: controller.textColor.value.withOpacity(0.7),
                    height: 1.5,
                  ),
                ),
                pW.Box(h: 32.h),

                // 按钮区域
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton('取消', () => Get.back(), false, controller),
                    Obx(
                      () => _buildButton(
                        controller.buttonText.value,
                        () => _onConfirm(controller),
                        true,
                        controller,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    String text,
    VoidCallback onTap,
    bool isPrimary,
    DemoCtrl controller,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isPrimary
                ? controller.primaryColor.value
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            border: isPrimary
                ? null
                : Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: isPrimary
                  ? Colors.white
                  : controller.textColor.value.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }

  void _onConfirm(DemoCtrl controller) {
    Get.snackbar(
      '提示',
      '确认按钮被点击',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF4CAF50),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void _showSettingsDialog(DemoCtrl controller) {
    Get.dialog(
      AlertDialog(
        title: const Text('组件设置'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSliderSetting('宽度', controller.width.value, 200, 500, (
                value,
              ) {
                controller.updateComponent(width: value);
              }),
              _buildSliderSetting('高度', controller.height.value, 300, 600, (
                value,
              ) {
                controller.updateComponent(height: value);
              }),
              _buildSliderSetting('圆角', controller.borderRadius.value, 0, 30, (
                value,
              ) {
                controller.updateComponent(borderRadius: value);
              }),
              _buildSliderSetting('阴影', controller.elevation.value, 0, 10, (
                value,
              ) {
                controller.updateComponent(elevation: value);
              }),
              _buildSliderSetting('图标大小', controller.iconSize.value, 40, 120, (
                value,
              ) {
                controller.updateComponent(iconSize: value);
              }),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('关闭')),
          TextButton(
            onPressed: () {
              controller.resetComponent();
              Get.back();
            },
            child: const Text('重置'),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSetting(
    String label,
    double value,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toInt()}'),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}

// 自定义裁剪路径类，实现Android中的圆角效果
class _TomatoClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // 对应Android的pathData="M24 0H371C384.255 0 395 10.7452 395 24V420C395 433.255 384.255 444 371 444H24C10.7452 444 0 433.255 0 420V24C0 10.7452 10.7452 0 24 0Z"
    // 创建圆角矩形路径
    const double cornerRadius = 24.0; // 对应Android中的24

    // 开始点
    path.moveTo(cornerRadius, 0);

    // 顶部右边
    path.lineTo(size.width - cornerRadius, 0);

    // 右上角圆角
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);

    // 右边
    path.lineTo(size.width, size.height - cornerRadius);

    // 右下角圆角
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - cornerRadius,
      size.height,
    );

    // 底部
    path.lineTo(cornerRadius, size.height);

    // 左下角圆角
    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);

    // 左边
    path.lineTo(0, cornerRadius);

    // 左上角圆角
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
