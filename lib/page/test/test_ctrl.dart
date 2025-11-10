

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/model/status/status_item.dart';
import 'package:rosun_fi_windows/page/test/test_page.dart';

import '../../widget/f_line_chart.dart';

class TestCtrl extends GetxController with GetSingleTickerProviderStateMixin{
  double radius = 3.r;
  List<StatusItem> statusList = [
    StatusItem("财务", false),
    StatusItem("行政", false),
    StatusItem("经理", false),
    StatusItem("市场", false),
  ];
  late AnimationController animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 300));
  final random = Random();
  double get latest => 8 + random.nextDouble() * 0.7;
  int get volume => 1000 + random.nextInt(10000);
  late final List<ChartData> dataList = List.generate(100, (i) {
    return ChartData(i.toDouble(), latest, volume);
  });
  late TextEditingController textEditingController = TextEditingController(
    text: "100",
  );

  double itemWidth = 20.w;

  double lineLeft = 0;
  double lineTop = 0;
  @override
  void onInit() {
    // animationController.repeat();
    animationController.addListener((){
      if(animationController.isCompleted){
        animationController.reset();
        itemWidth = 0;
        update();
      }
    });
    super.onInit();
    // 初始化逻辑
  }

  @override
  void onClose() {
    super.onClose();
    // 清理逻辑
  }

  selectItem(index) {
    final item = statusList[index];
    item.status = !item.status;
    update();
  }
}
