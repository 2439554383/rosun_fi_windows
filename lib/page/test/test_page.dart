import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/commen/font_style.dart';
import 'package:rosun_fi_windows/extension/e_String.dart';
import 'package:rosun_fi_windows/gen/assets.gen.dart';
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
    final fullWidth = MediaQuery.of(context).size.width;
    final fullHeight = MediaQuery.of(context).size.height;
    return GetBuilder<TestCtrl>(
      init: TestCtrl(),
      builder: (ctrl) {
        print("重绘scaffold");
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text('测试页面'),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF333333),
            elevation: 0,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: Icon(Icons.drag_indicator_rounded),
            ),
          ),
          body: SingleChildScrollView(
            controller: ctrl.scrollController,
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
            child: Container(
              width: fullWidth + ctrl.deawWidth,
              height: fullHeight,
              child: Row(
                children: [
                  AnimatedContainer(
                    width: ctrl.deawWidth,
                    height: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    color: Colors.white,
                    duration: Duration(milliseconds: 300),
                    child: Column(
                      spacing: 35.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        Row(
                          children: [
                            AnimatedRotation(
                              turns: ctrl.turns,
                              duration: Duration(milliseconds: 500),
                              child: ClipOval(
                                child: Assets.images.banner.image(
                                  width: 55.w,
                                  height: 55.h,
                                  fit: BoxFit.cover,
                                ),
                                clipBehavior: Clip.hardEdge,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text("骆旭东", style: MyFont().black_4_18),
                          ],
                        ),
                        Stack(
                          children: [
                            AnimatedContainer(
                              width: ctrl.backWidth,
                              height: 45.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp),
                                color: Colors.lightBlueAccent.withOpacity(0.5),
                              ),
                              duration: Duration(milliseconds: 500),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 8.h,
                              ),
                              child: Text("欢迎回来抽屉", style: MyFont().black_4_18),
                            ),
                          ],
                        ),
                        Text("欢迎回来抽屉", style: MyFont().black_4_18),
                        Text("欢迎回来抽屉", style: MyFont().black_4_18),
                        Text("欢迎回来抽屉", style: MyFont().black_4_18),
                        Text("欢迎回来抽屉", style: MyFont().black_4_18),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: fullWidth,
                      height: fullHeight,
                      margin: EdgeInsets.symmetric(
                        horizontal: 25.w,
                        vertical: 25.h,
                      ),
                      child: _buildTestContent(pW, controller),
                    ),
                  ),
                ],
              ),
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
    final double indicatorWidth = 45.w;
    final double horizontalLabelWidth = 45.w;

    return ListView(
      children: [
        // 调试信息显示
        GestureDetector(
          onTap: () {
            ctrl.showDraw();
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            alignment: Alignment.centerLeft,
            width: 200,
            child: ctrl.hasDraw
                ? Icon(CupertinoIcons.back, color: Colors.white, size: 35.sp)
                : Icon(
                    Icons.drag_indicator_rounded,
                    color: Colors.white,
                    size: 35.sp,
                  ),
          ),
        ),
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
              ctrl.tradeMode();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey[900]),
            ),
            child: Text("点击交易"),
          ),
        ),
        fBox(),
        AnimatedBuilder(
          animation: ctrl.animationController,
          builder: (BuildContext context, Widget? child) {
            final value = ctrl.animationController.value;
            return Center(
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Text("股票数据更新"),
                  Positioned(
                    left: 100.w * value,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: ctrl.itemWidth.value,
                      color: Colors.green.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        fBox(),
        //分时折线图
        Center(
          child: SizedBox(
            width: 300.w,
            child: Stack(
              fit: StackFit.passthrough,
              clipBehavior: Clip.hardEdge,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onScaleStart: ctrl.handleScaleStart,
                      onScaleUpdate: (details) {
                        if (details.pointerCount < 2) {
                          return;
                        }
                        ctrl.handleScaleUpdate(details);
                      },
                      onLongPressStart: (detail) {
                        ctrl.isDrag.value = true;
                        ctrl.lineLeft.value = detail.localPosition.dx;
                        ctrl.lineTop.value = detail.localPosition.dy;
                      },
                      onLongPressMoveUpdate: (detail) {
                        ctrl.moveUpdate(detail);
                      },
                      onLongPressEnd: (details) {
                        ctrl.isDrag.value = false;
                        ctrl.lineLeft.value = 0;
                        ctrl.lineTop.value = 0;
                      },
                      child: Container(
                        width: 300.w,
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
                            Obx(() {
                              print("-------重绘交易点-------");
                              return TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: 3.r,
                                  end: ctrl.radius.value,
                                ),
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
                              );
                            }),
                            Positioned(
                              top: 3.h,
                              left: 3.w,
                              child: Text('9.15'),
                            ),
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
                            Positioned(
                              bottom: 3.h,
                              left: 3.w,
                              child: const Text('7.7'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300.w,
                      height: 30.h,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: 3.h,
                            left: 3.w,
                            child: const Text('9.30'),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 3,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('11.30'),
                            ),
                          ),
                          Positioned(
                            top: 3,
                            right: 3.w,
                            child: const Text('15.00'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 300.w,
                      height: 75.h,
                      child: CustomPaint(
                        painter: FColumnChart(
                          max: 11000,
                          min: 1000,
                          width: 1.w,
                          dataList: ctrl.dataList,
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  print("---------重绘十字线--------");
                  if (!ctrl.isDrag.value) {
                    return const SizedBox.shrink();
                  }
                  return Positioned.fill(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: ctrl.lineLeft.value,
                          top: 0,
                          bottom: 0,
                          child: SizedBox(
                            width: indicatorWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 1,
                                    height: 300.h,
                                    color: Colors.grey,
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(-indicatorWidth / 2, 0),
                                  child: Container(
                                    width: indicatorWidth,
                                    height: 20.h,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                    ),
                                    child: Text(
                                      '${ctrl.currentX.value}',
                                      style: MyFont().white_4_12,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 1,
                                    height: 75.h,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: ctrl.lineTop.value,
                          child: SizedBox(
                            width: 300.w,
                            height: 20.h,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Transform.translate(
                                  offset: Offset(0, -10.h),
                                  child: Container(
                                    width: horizontalLabelWidth,
                                    height: 20.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                    ),
                                    child: Text(
                                      '${ctrl.currentY.value}',
                                      style: MyFont().white_4_12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: 1.h,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        fBox(),
        Center(
          child: Text(
            "--------------蜡烛图---------------",
            style: MyFont().white_4_18,
          ),
        ),
        fBox(),
        //蜡烛图
        Center(
          child: SizedBox(
            width: 300.w,
            child: Stack(
              fit: StackFit.passthrough,
              clipBehavior: Clip.hardEdge,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onLongPressStart: (detail) {
                        ctrl.isCandleDrag.value = true;
                        ctrl.lineLeft.value = detail.localPosition.dx;
                        ctrl.lineTop.value = detail.localPosition.dy;
                      },
                      onLongPressMoveUpdate: (detail) {
                        ctrl.candleMoveUpdate(detail);
                      },
                      onLongPressEnd: (details) {
                        ctrl.isCandleDrag.value = false;
                        ctrl.lineLeft.value = 0;
                        ctrl.lineTop.value = 0;
                      },
                      child: Container(
                        width: 300.w,
                        height: 300.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Obx(() {
                              final scale = ctrl.chartScale.value;
                              final double barWidth = 25.w * scale;
                              final double spacing = 5.w * scale;
                              return ListView.builder(
                                itemCount: ctrl.candleList.length,
                                scrollDirection: Axis.horizontal,
                                controller: ctrl.candleController,
                                itemExtent: barWidth + spacing,
                                itemBuilder: (context, index) {
                                  final item = ctrl.candleList[index];
                                  final high = item.high;
                                  final low = item.low;
                                  final close = item.close;
                                  final open = item.open;
                                  final bool isUp = (close - open) > 0;
                                  final double candleHeight = close * 10;
                                  final Color color = isUp
                                      ? Colors.red
                                      : Colors.green;
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spacing / 2,
                                    ),
                                    child: SizedBox(
                                      width: barWidth,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: candleHeight),
                                          Container(
                                            height: high,
                                            width: 1.w,
                                            color: color,
                                          ),
                                          Container(
                                            height: (open - close).abs() * 100,
                                            width: barWidth,
                                            color: color,
                                          ),
                                          Container(
                                            height: low,
                                            width: 1.w,
                                            color: color,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                            Positioned(
                              top: 3.h,
                              left: 3.w,
                              child: Text('9.15'),
                            ),
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
                            Positioned(
                              bottom: 3.h,
                              left: 3.w,
                              child: const Text('7.7'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300.w,
                      height: 30.h,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: 3.h,
                            left: 3.w,
                            child: const Text('9.30'),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 3,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('11.30'),
                            ),
                          ),
                          Positioned(
                            top: 3,
                            right: 3.w,
                            child: const Text('15.00'),
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      final scale = ctrl.chartScale.value;
                      final double barWidth = 25.w * scale;
                      final double spacing = 5.w * scale;
                      return SizedBox(
                        height: 75.h,
                        width: 300.w,
                        child: ListView.builder(
                          itemCount: ctrl.candleList.length,
                          scrollDirection: Axis.horizontal,
                          controller: ctrl.volumeController,
                          itemExtent: barWidth + spacing,
                          itemBuilder: (context, index) {
                            final item = ctrl.candleList[index];
                            final double close = item.close;
                            final double open = item.open;
                            final bool isUp = (close - open) > 0;
                            final Color color = isUp
                                ? Colors.red
                                : Colors.green;
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: spacing / 2,
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: (open - close).abs() * 100,
                                  width: barWidth,
                                  color: color,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ],
                ),
                Obx(() {
                  print("---------重绘十字线--------");
                  if (!ctrl.isCandleDrag.value) {
                    return const SizedBox.shrink();
                  }
                  return Positioned.fill(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: ctrl.lineLeft.value,
                          top: 0,
                          bottom: 0,
                          child: SizedBox(
                            width: indicatorWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 1,
                                    height: 300.h,
                                    color: Colors.grey,
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(-indicatorWidth / 2, 0),
                                  child: Container(
                                    width: indicatorWidth,
                                    height: 20.h,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                    ),
                                    child: Text(
                                      '${ctrl.currentX.value}',
                                      style: MyFont().white_4_12,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 1,
                                    height: 75.h,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: ctrl.lineTop.value,
                          child: SizedBox(
                            width: 300.w,
                            height: 20.h,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Transform.translate(
                                  offset: Offset(0, -10.h),
                                  child: Container(
                                    width: horizontalLabelWidth,
                                    height: 20.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                    ),
                                    child: Text(
                                      '${ctrl.currentY.value}',
                                      style: MyFont().white_4_12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: 1.h,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        fBox(),
      ],
    );
  }
}
