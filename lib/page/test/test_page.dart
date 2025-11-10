import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/extension/e_String.dart';
import 'package:rosun_fi_windows/widget/add_and_subtract.dart';
import 'package:rosun_fi_windows/widget/f_column_chart.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'package:rosun_fi_windows/widget/tap_to_expand.dart';
import 'package:rosun_fi_windows/widget/water_loading.dart';
import '../../widget/f_line_chart.dart';
import '../../widget/selection_button.dart';
import '../../widget/switchCountAni.dart';
import '../../widget/tradePoint.dart';
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

  Widget fBox() {
    return SizedBox(height: 20.h);
  }

  Widget _buildTestContent(PublicWidget pW, TestCtrl ctrl) {
    // 获取当前使用的设计尺寸
    final designSize = Platform.isWindows
        ? const Size(1920, 1080)
        : const Size(375, 812);

    return ListView(
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
            ...List.generate(6, (index) {
              return Row(
                children: [
                  Text("data"),
                  Tooltip(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                      ),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    message: '这是一个提示信息',
                    triggerMode: TooltipTriggerMode.longPress,
                    child: Icon(Icons.info_outline),
                  ),
                ],
              );
            }),
          ],
        ),
        fBox(),
        AnimatedFlipper(),
        fBox(),
        TapToExpend(),
        fBox(),
        Center(child: CustomLiquidProgressIndicator()),
        fBox(),
        Container(
          height: 45.h,
          child: ElevatedButton(
            onPressed: () {
              ctrl.radius = 5.r;
              ctrl.update();
              Future.delayed(Duration(milliseconds: 100), () {
                ctrl.radius = 3.r;
                ctrl.update();
              });
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey[900]),
            ),
            child: Text("点击交易"),
          ),
        ),
        fBox(),
        Stack(
          fit: StackFit.passthrough,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onLongPressStart: (detail){
                    ctrl.lineLeft = detail.localPosition.dx;
                    ctrl.lineTop = detail.localPosition.dy;
                    ctrl.update();
                  },
                  onLongPressMoveUpdate: (detail) {
                    print('移动中: ${detail.localPosition}');
                    ctrl.lineLeft = detail.localPosition.dx;
                    ctrl.lineTop = detail.localPosition.dy;
                    ctrl.update();
                  },
                  onLongPressEnd: (details) {
                    print('长按结束');
                    ctrl.lineLeft = 0;
                    ctrl.lineTop = 0;
                    ctrl.update();
                  },
                  child: Container(
                    height: 300.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomPaint(
                          painter: FLineChart(
                            max: 9.15,
                            min: 7.7,
                            dataList: ctrl.dataList,
                          ),
                        ),
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 3.r, end: ctrl.radius),
                          duration: const Duration(milliseconds: 100),
                          builder: (context, animatedRadius, child) {
                            return CustomPaint(
                              painter: TrandePoint(
                                max: 9.15,
                                min: 7.7,
                                radius: animatedRadius,
                                dataList: ctrl.dataList,
                              ),
                            );
                          },
                        ),
                        Positioned(top: 3.h, left: 3.w, child: Text('9.15')),
                        Positioned(
                          left: 3.w,
                          top: 0,
                          bottom: 0,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${((9.15 + 7.7) / 2).toStringAsFixed(2)}',
                            ),
                          ),
                        ),
                        Positioned(bottom: 3.h, left: 3.w, child: Text('7.7')),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(top: 3.h, left: 3.w, child: Text('9.30')),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 3,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('11.30'),
                        ),
                      ),
                      Positioned(top: 3, right: 3.w, child: Text('15.00')),
                    ],
                  ),
                ),
                SizedBox(
                  height: 75.h,
                  child: CustomPaint(
                    painter: FColumnChart(
                      max: 11000,
                      min: 1000,
                      dataList: ctrl.dataList,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: ctrl.lineLeft,
              top: 0,
              bottom: 0,
              child: Container(width: 1, color: Colors.grey),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: ctrl.lineTop,
              child: Container(height: 1, color: Colors.grey),
            ),
          ],
        ),
        fBox(),
        GestureDetector(
          onTap: (){
            ctrl.itemWidth = 20.w;
            ctrl.update();
            ctrl.animationController.reset();
            ctrl.animationController.forward();
          },
          child: AnimatedBuilder(
            animation: ctrl.animationController,
            builder: (BuildContext context, Widget? child) {
              final value = ctrl.animationController.value;
              return Center(
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Text("股票数据更新"),
                    Positioned(
                        left: 100.w*value,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: ctrl.itemWidth,
                          color: Colors.green.withOpacity(0.4),
                        )
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
