import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/model/status/status_item.dart';

class TestCtrl extends GetxController {
  double radius = 3.r;
  List<StatusItem> statusList = [
    StatusItem("财务", false),
    StatusItem("行政", false),
    StatusItem("经理", false),
    StatusItem("市场", false),
  ];
  late TextEditingController textEditingController = TextEditingController(
    text: "100",
  );
  @override
  void onInit() {
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
