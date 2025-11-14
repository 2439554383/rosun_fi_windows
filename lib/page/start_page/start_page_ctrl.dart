import 'package:get/get.dart';
import 'package:rosun_fi_windows/extension/e_String.dart';

class StartPageCtrl extends GetxController {
  String text1 = "Hello, 您即将进入 " ;
  String text2 = "一个有趣的世界~ " ;
  String? startText1 = "" ;
  String? startText2 = "" ;
  //
  @override
  void onInit() {
    animatedText ();
    super.onInit();
    // 初始化逻辑
  }

  @override
  void onClose() {
    super.onClose();
    // 清理逻辑
  }

  animatedText () async {
    for( int i = 0 ; i<text1.length; i++){
      await Future.delayed(Duration(milliseconds: 100),(){
        startText1  = text1.substring(0,i);
        update();
      });
    }
    for( int i = 0 ; i<text2.length; i++){
      await Future.delayed(Duration(milliseconds: 100),(){
        startText2  = text2.substring(0,i);
        update();
      });
    }
  }

}


