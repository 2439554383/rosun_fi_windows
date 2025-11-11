import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:rosun_fi_windows/model/status/status_item.dart';
import '../../widget/f_line_chart.dart';

class CandleData {
  const CandleData({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;
}

class TestCtrl extends GetxController with GetSingleTickerProviderStateMixin {
  Rx<double> radius = 3.r.obs;
  List<StatusItem> statusList = [
    StatusItem("财务", false),
    StatusItem("行政", false),
    StatusItem("经理", false),
    StatusItem("市场", false),
  ];
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 300),
  );
  final random = Random();
  double get latest => 8 + random.nextDouble() * 0.7;
  int get volume => 1000 + random.nextInt(10000);
  late final List<ChartData> dataList = List.generate(100, (i) {
    return ChartData(i.toDouble(), latest, volume);
  });
  late final List<CandleData> candleList = _generateCandleData();
  late TextEditingController textEditingController = TextEditingController(
    text: "100",
  );
  late final LinkedScrollControllerGroup group;
  late final ScrollController candleController;
  late final ScrollController volumeController;
  Rx<double> itemWidth = 20.w.obs;
  Rx<double> chartScale = 1.0.obs;
  double _scaleBase = 1.0;

  Rx<double> lineLeft = 0.00.obs;
  Rx<double> lineTop = 0.00.obs;

  Rx<num> currentX = 0.00.obs;
  Rx<num> currentY = 0.00.obs;

  Rx<bool> isDrag = false.obs;
  Rx<bool> isCandleDrag = false.obs;
  @override
  void onInit() {
    group = LinkedScrollControllerGroup();
    candleController = group.addAndGet();
    volumeController = group.addAndGet();
    super.onInit();
    // 初始化逻辑
  }

  @override
  void onClose() {
    candleController.dispose();
    volumeController.dispose();
    super.onClose();
    // 清理逻辑
  }

  selectItem(index) {
    final item = statusList[index];
    item.status = !item.status;
    update();
  }

  double mapValue(
    double y,
    double inMin,
    double inMax,
    double outMin,
    double outMax,
  ) {
    return outMax - (inMin + (y - inMin) / (inMax - inMin) * (outMax - outMin));
  }

  List<CandleData> _generateCandleData() {
    final DateTime today = DateTime.now();
    double previousClose = 8 + random.nextDouble() * 0.5;

    return List.generate(100, (index) {
      final DateTime date = today.subtract(Duration(days: 100 - index));
      final double trend = (random.nextDouble() - 0.5) * 0.4;

      final double open = (previousClose + trend / 2).clamp(7.2, 9.5).toDouble();
      final double high = (open + random.nextDouble() * 0.35).clamp(open, 9.8).toDouble();
      final double low = (open - random.nextDouble() * 0.35).clamp(6.8, open).toDouble();
      final double close = (low + random.nextDouble() * (high - low)).clamp(low, high).toDouble();

      // 🔹 新增：成交量（volume）区间 10000 ~ 11000
      final int volume = 10000 + random.nextInt(1001); // nextInt(1001) → [0, 1000]

      previousClose = close;

      return CandleData(
        date: date,
        open: _round(open),
        high: _round(high),
        low: _round(low),
        close: _round(close),
        volume: volume, // ✅ 新增字段
      );
    });
  }


  double _round(double value) =>
      (value * 100).roundToDouble() / 100;

  List<Offset> linePosition() {
    if (dataList.length < 2) {
      return [];
    }
    final double width = 300.w;
    final double height = 300.h;
    const double min = 7.7;
    const double max = 9.2;

    final List<Offset> points = <Offset>[];
    for (int i = 0; i < dataList.length; i++) {
      final item = dataList[i];
      final double x = width / (dataList.length - 1) * i;
      final double y = height - ((item.latest - min) / (max - min)) * height;
      points.add(Offset(x, y));
    }
    return points;
  }

  void tradeMode() {
    radius.value = 5.r;
    itemWidth.value = 20.w;
    animationController.reset();
    animationController.forward();
    Future.delayed(Duration(milliseconds: 100), () {
      radius.value = 3.r;
    });
  }

  void moveUpdate(LongPressMoveUpdateDetails detail) {
    final double dx = detail.localPosition.dx;
    final double dy = detail.localPosition.dy;
    if ((dy > 300.h && dy < 330.h) ||
        dx > 300.w ||
        dx < 0 ||
        dy < 0 ||
        dy > 405.h) {
      return;
    }
    final List<Offset> pointList = linePosition();
    final List<double> diffList = pointList
        .map((offset) => (offset.dx - dx).abs())
        .toList();

    if (diffList.isEmpty) {
      print('⚠️ linePosition() 返回为空，无法定位最近点');
      return;
    }

    final double minDiff = diffList.reduce(min);
    final int index = diffList.indexOf(minDiff);
    final Offset point = pointList[index];

    // 👉 输出调试信息（中文分行）
    print('==== 拖动事件详情 ====');
    print('触摸点坐标：dx=${detail.localPosition.dx}, dy=${detail.localPosition.dy}');
    print('最近点索引：$index');
    print('最近点的横向差值：$minDiff');
    print('最近点坐标：(${point.dx}, ${point.dy})');
    print('线条位置（更新前）：lineLeft=${lineLeft.value}, lineTop=${lineTop}');
    print('当前数据（更新前）：日期=${currentX.value}, 数值=${currentY.value}');
    print('=====================');

    // 更新控制器
    lineLeft.value = point.dx;
    lineTop.value = detail.localPosition.dy;
    currentX.value = dataList[index].date;
    currentY.value = lineTop.value > 330.h
        ? mapValue(detail.localPosition.dy, 0, 75.h, 10000, 11000)
        : lineTop.value < 300.h
        ? mapValue(detail.localPosition.dy, 0, 300.h, 7.7, 9.15)
        : 0.00;

    // 👉 输出更新后的状态
    print('==== 控制器更新后 ====');
    print('线条位置：lineLeft=${lineLeft.value}, lineTop=${lineTop.value}');
    print('当前数据：日期=${currentX.value}, 数值=${currentY.value}');
    print('=====================');
  }

  void handleScaleStart(ScaleStartDetails details) {
    _scaleBase = chartScale.value;
  }

  void handleScaleUpdate(ScaleUpdateDetails details) {
    final double updated = (_scaleBase * details.scale).clamp(0.6, 2.4);
    chartScale.value = updated;
  }

  void candleMoveUpdate(LongPressMoveUpdateDetails detail) {
    final double dx = detail.localPosition.dx;
    final double dy = detail.localPosition.dy;
    if ((dy > 300.h && dy < 330.h) ||
        dx > 300.w ||
        dx < 0 ||
        dy < 0 ||
        dy > 405.h) {
      return;
    }
    final List<Offset> pointList = linePosition();
    final List<double> diffList = pointList
        .map((offset) => (offset.dx - dx).abs())
        .toList();

    if (diffList.isEmpty) {
      print('⚠️ linePosition() 返回为空，无法定位最近点');
      return;
    }

    final double minDiff = diffList.reduce(min);
    final int index = diffList.indexOf(minDiff);
    final Offset point = pointList[index];

    // 👉 输出调试信息（中文分行）
    print('==== 拖动事件详情 ====');
    print('触摸点坐标：dx=${detail.localPosition.dx}, dy=${detail.localPosition.dy}');
    print('最近点索引：$index');
    print('最近点的横向差值：$minDiff');
    print('最近点坐标：(${point.dx}, ${point.dy})');
    print('线条位置（更新前）：lineLeft=${lineLeft.value}, lineTop=${lineTop}');
    print('当前数据（更新前）：日期=${currentX.value}, 数值=${currentY.value}');
    print('=====================');

    // 更新控制器
    lineLeft.value = point.dx;
    lineTop.value = detail.localPosition.dy;
    currentX.value = dataList[index].date;
    currentY.value = lineTop.value > 330.h
        ? mapValue(detail.localPosition.dy, 0, 75.h, 10000, 11000)
        : lineTop.value < 300.h
        ? mapValue(detail.localPosition.dy, 0, 300.h, 7.7, 9.15)
        : 0.00;

    // 👉 输出更新后的状态
    print('==== 控制器更新后 ====');
    print('线条位置：lineLeft=${lineLeft.value}, lineTop=${lineTop.value}');
    print('当前数据：日期=${currentX.value}, 数值=${currentY.value}');
    print('=====================');

  }
}
