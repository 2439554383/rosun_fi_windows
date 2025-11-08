import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/extension/e_String.dart';
import 'package:rosun_fi_windows/widget/add_and_subtract.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'package:rosun_fi_windows/widget/tap_to_expand.dart';
import '../../widget/selection_button.dart';
import '../../widget/switchCountAni.dart';
import 'test_ctrl.dart';

class TestPage extends GetView<TestCtrl> {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<TestCtrl>(
      init: TestCtrl(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text('测试页面'),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF333333),
            elevation: 0,
            centerTitle: true,
          ),
          body: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
              child: _buildTestContent(pW, controller),
            ),
          ),
        );
      },
    );
  }
  Widget fBox(){
    return SizedBox(height: 20.h);
  }
  Widget _buildTestContent(PublicWidget pW, TestCtrl ctrl) {
    // 获取当前使用的设计尺寸
    final designSize = Platform.isWindows
        ? const Size(1920, 1080)
        : const Size(375, 812);

    return ListView(
      shrinkWrap: true,
      children: [
        // 调试信息显示
        Container(
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              fBox(),
              Text(
                '📱 平台信息',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '平台: ${Platform.isWindows ? "Windows" : "移动端"}',
                style: TextStyle(fontSize: 14.sp),
              ),
              Text(
                '设计尺寸: ${designSize.width.toInt()} × ${designSize.height.toInt()}',
                style: TextStyle(fontSize: 14.sp),
              ),
              Text(
                '屏幕尺寸: ${1.sw.toInt()} × ${1.sh.toInt()}',
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
        ),
        fBox(),
        SelectionButton(
          statusList: ctrl.statusList,
          radius: 8.r,
          color: Colors.black,
          textStyle: TextStyle(color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          shrinkWrap: true,
          callBack: (index) {
            ctrl.selectItem(index);
          },
        ),
        fBox(),
        AddAndSubtract(
            height: 65.h,
            growing: 300,
            controller: ctrl.textEditingController,
            min: 100,
            max: 1500,
            borderColor: Colors.transparent,
            radius: 20.r,
            type: Type.connect,
        ),
        fBox(),
        Text("10000.22".encryption),
        fBox(),
        Row(
          children: [
            ...List.generate(6, (index){
              return Row(
                children: [
                  Text("data"),
                  Tooltip(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r)),
                      color: Colors.black.withOpacity(0.5)
                    ),
                    message: '这是一个提示信息',
                    triggerMode: TooltipTriggerMode.longPress,
                    child: Icon(Icons.info_outline),
                  )
                ],
              );
            })
          ],
        ),
        fBox(),
        AnimatedFlipper(),
        fBox(),
        TapToExpend(),
        fBox(),

      ],
    );
  }
}
