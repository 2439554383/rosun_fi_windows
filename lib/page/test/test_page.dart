import 'dart:io' show Platform;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/extension/e_String.dart';
import 'package:rosun_fi_windows/widget/add_and_subtract.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import 'package:rosun_fi_windows/widget/tap_to_expand.dart';
import 'package:rosun_fi_windows/widget/water_loading.dart';
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
              onPressed: (){
                ctrl.radius = 5.r;
                ctrl.update();
                Future.delayed(Duration(milliseconds: 100),(){
                  ctrl.radius = 3.r;
                  ctrl.update();
                });
              },
              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.grey[900])),
              child: Text("点击交易")
          ),
        ),
        fBox(),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Stack(
            children: [
              Container(
                width: 300.w,
                height: 300.h,
                child: TweenAnimationBuilder(
                    tween: Tween(begin: 3.r,end: ctrl.radius),
                    duration: Duration(milliseconds: 300),
                    builder: (context,size,child){
                      return CustomPaint(
                          painter: FLineChart(max: 9.15,min: 7.7, radius: ctrl.radius)
                      );
                    }
                ),
              ),
              Positioned(
                  top: 3.h,
                  left: 3.w,
                  child: Text("9.15")
              ),
              Positioned(
                left: 3.w,
                top: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("${((9.15+7.7)/2).toStringAsFixed(2)}"),
                ),
              ),
              Positioned(
                  bottom: 3.h,
                  left: 3.w,
                  child: Text("7.7")
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 30.h,
          child: Stack(
            children: [
              Positioned(
                  top: 3.h,
                  left: 3.w,
                  child: Text("9.30")
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 3,
                child: Align(
                    alignment: Alignment.center,
                    child: Text("11.30")
                ),
              ),
              Positioned(
                  top: 3,
                  right: 3.w,
                  child: Text("15.00")
              )
            ],
          ),
        )
      ],
    );
  }
}

class FLineChart extends CustomPainter {
  double min;
  double max;
  double radius;
  FLineChart({required this.min, required this.max, required this.radius});


  final random = Random();
  double get latest => 8 + random.nextDouble() * 0.7;
  int get volume => 1000 + random.nextInt(10000);

  late final List<ChartData> dataList = List.generate(100, (i) {
    return ChartData(i.toDouble(), latest, volume);
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path();

    // 取出最大最小值，用于归一化映射
    // final minY = dataList.map((e) => e.latest).reduce(min);
    // final maxY = dataList.map((e) => e.latest).reduce(max);

    for (int i = 0; i < dataList.length; i++) {
      final item = dataList[i];

      // x 坐标：按索引分布在宽度内
      final x = size.width / (dataList.length - 1) * i;

      // y 坐标：将价格映射到画布高度（反转 Y 轴）
      final y = size.height -
          ((item.latest - min) / (max - min)) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      }
      else if( i == (dataList.length -1)){
        path.lineTo(x, y);
        canvas.drawCircle(Offset(x, y), radius.r, paint);
      }
      else {
        path.lineTo(x, y);
      }

    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}

class ChartData {
  final double date;
  final double latest;
  final int volume;

  ChartData(this.date, this.latest, this.volume);
}
