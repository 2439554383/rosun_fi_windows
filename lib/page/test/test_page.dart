import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/commen/font_style.dart';
import 'package:rosun_fi_windows/widget/add_and_subtract.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import '../../widget/selection_button.dart';
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
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            title: const Text('测试页面'),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF333333),
            elevation: 0,
            centerTitle: true,
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buildTestContent(pW, controller)],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTestContent(PublicWidget pW, TestCtrl ctrl) {
    return Column(
      children: [
        Text(
          '测试页面',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
        pW.Box(h: 20.h),
        Text(
          '这是一个测试页面',
          style: TextStyle(fontSize: 16.sp, color: const Color(0xFF666666)),
        ),
        SelectionButton(
          statusList: ctrl.statusList,
          radius: 8.r,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          textStyle: MyFont().black_4_18,
          shrinkWrap: true,
          callBack: (index) {
            ctrl.selectItem(index);
          },
        ),
        AddAndSubtract(
            height: 65.h,
            growing: 300,
            controller: ctrl.textEditingController,
            min: 100,
            max: 1500,
        ),
      ],
    );
  }
}
