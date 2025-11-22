import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'spirit_ctrl.dart';

class Spirit extends GetView<SpiritCtrl> {
  const Spirit({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<SpiritCtrl>(
      init: SpiritCtrl(),
      builder: (ctrl) {
        return FocusDetector(
          onFocusGained: () {
            ctrl.pageFocus();
          },
          onFocusLost: () {
            ctrl.pageUnFocus();
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    pW.Box(h: 30.h),
                    // 在这里添加你的组件内容
                    Text(
                      '心灵空间',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    pW.Box(h: 20.h),
                    Text(
                      '冥想音乐、自然白噪音、助眠故事，治愈你的心灵',
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

