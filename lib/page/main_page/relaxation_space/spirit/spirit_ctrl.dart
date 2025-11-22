import 'package:get/get.dart';

class SpiritCtrl extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("SpiritCtrl初始化");
  }

  @override
  void onClose() {
    print("SpiritCtrl销毁");
    super.onClose();
  }

  void pageFocus() {
    print("聚焦SpiritCtrl");
  }

  void pageUnFocus() {
    print("失焦SpiritCtrl");
  }
}

