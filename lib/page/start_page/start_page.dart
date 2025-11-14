import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/commen/font_style.dart';
import 'package:rosun_fi_windows/gen/fonts.gen.dart';
import 'package:rosun_fi_windows/page/main_page/main_page.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import '../../gen/assets.gen.dart';
import 'start_page_ctrl.dart';

class StartPage extends GetView<StartPageCtrl> {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return GetBuilder<StartPageCtrl>(
      init: StartPageCtrl(),
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    pW.Box(h: 30.h),
                    Assets.images.startTop.image(),
                    Text(
                      "${ctrl.startText1}\n${ctrl.startText2}",
                      style: MyFont().black_4_25.copyWith(
                        fontFamily: FontFamily.workSans,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    pW.Box(h: 75.h),
                    Material(
                      borderRadius: BorderRadius.circular(99.r),
                      clipBehavior: Clip.hardEdge,
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.deepPurple, Colors.pinkAccent],
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                                MainPage(),
                                duration: Duration(milliseconds: 300),
                                transition: Transition.circularReveal,
                                curve: Curves.linear
                            );
                          },
                          child: Container(
                            width: 75.w,
                            height: 75.h,
                            child: Icon(
                              Icons.arrow_right_alt_outlined,
                              size: 45.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
