import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/widget/public.dart';
import '../../commen/font_style.dart';
import '../../gen/assets.gen.dart';
import '../../gen/fonts.gen.dart';
import 'main_page_ctrl.dart';

class MainPage extends GetView<MainPageCtrl> {
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    final fullWidth = MediaQuery.of(context).size.width;
    final fullHeight = MediaQuery.of(context).size.height;
    return GetBuilder<MainPageCtrl>(
      init: MainPageCtrl(),
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            controller: ctrl.scrollController,
            scrollDirection: Axis.horizontal,
            reverse: true,
            physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
            child: Container(
              width: fullWidth + ctrl.deawWidth,
              height: fullHeight,
              child: Stack(
                children: [
                  AnimatedContainer(
                    width: ctrl.deawWidth,
                    height: double.infinity,
                    margin: EdgeInsets.only(left: ctrl.deawWidth),
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.white,Colors.yellow.shade100,Colors.orange.shade100,Colors.white],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                        )
                    ),
                    duration: Duration(milliseconds: 300),
                    child: Transform(
                      transform: Matrix4.translationValues(
                          ctrl.scrollController.hasClients
                              ? -ctrl.scrollController.offset
                              : 0.0,
                          0.0,
                          0.0),
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
                                  color: Colors.deepPurple.withOpacity(0.5),
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
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: ctrl.deawWidth,
                        height: double.infinity,
                        color: Colors.transparent,
                      ),
                      // AnimatedContainer(
                      //   width: ctrl.deawWidth,
                      //   height: double.infinity,
                      //   padding: EdgeInsets.symmetric(horizontal: 15.w),
                      //   decoration: BoxDecoration(
                      //       gradient: LinearGradient(
                      //           colors: [Colors.white,Colors.yellow.shade100,Colors.orange.shade100,Colors.white],
                      //           begin: Alignment.topCenter,
                      //           end: Alignment.bottomCenter
                      //       )
                      //   ),
                      //   duration: Duration(milliseconds: 300),
                      //   child: Column(
                      //     spacing: 35.h,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       SizedBox(height: 30.h),
                      //       Row(
                      //         children: [
                      //           AnimatedRotation(
                      //             turns: ctrl.turns,
                      //             duration: Duration(milliseconds: 500),
                      //             child: ClipOval(
                      //               child: Assets.images.banner.image(
                      //                 width: 55.w,
                      //                 height: 55.h,
                      //                 fit: BoxFit.cover,
                      //               ),
                      //               clipBehavior: Clip.hardEdge,
                      //             ),
                      //           ),
                      //           SizedBox(width: 10.w),
                      //           Text("骆旭东", style: MyFont().black_4_18),
                      //         ],
                      //       ),
                      //       Stack(
                      //         children: [
                      //           AnimatedContainer(
                      //             width: ctrl.backWidth,
                      //             height: 45.h,
                      //             padding: EdgeInsets.symmetric(
                      //               horizontal: 15.w,
                      //               vertical: 8.h,
                      //             ),
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(15.sp),
                      //               color: Colors.deepPurple.withOpacity(0.5),
                      //             ),
                      //             duration: Duration(milliseconds: 500),
                      //           ),
                      //           Container(
                      //             padding: EdgeInsets.symmetric(
                      //               horizontal: 15.w,
                      //               vertical: 8.h,
                      //             ),
                      //             child: Text("欢迎回来抽屉", style: MyFont().black_4_18),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Expanded(
                        child: Container(
                          width: fullWidth,
                          height: fullHeight,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white,Colors.yellow.shade100,Colors.orange.shade100,Colors.white],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter
                              ),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(-1, 0),
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                    color: Colors.grey.withOpacity(0.5)
                                )
                              ]
                          ),
                          child:SafeArea(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 25.h,),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            ctrl.showDraw();
                                          },
                                          behavior: HitTestBehavior.opaque,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: ctrl.hasDraw
                                                ? Icon(CupertinoIcons.back,size: 35.sp)
                                                : Icon(
                                              Icons.menu_open_outlined,
                                              size: 35.sp,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 55.w,),
                                        Text("欢迎来到小世界",style: MyFont().black_4_25.copyWith(fontFamily: FontFamily.roboto),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 25.h,),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                                    child: GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio:5/4
                                        ),
                                        itemCount: ctrl.categoryList.length,
                                        itemBuilder: (context, index) {
                                          final item = ctrl.categoryList[index];
                                          final isInitialized =
                                          ctrl.initializedItems.contains(index);

                                          return AnimatedSlide(
                                            offset: Offset(0, isInitialized ? 0 : 0.2),
                                            duration: const Duration(milliseconds: 500),
                                            curve: Curves.easeOut,
                                            child: AnimatedOpacity(
                                              opacity: isInitialized ? 1 : 0,
                                              duration: const Duration(milliseconds: 500),
                                              curve: Curves.easeOut,
                                              child: GestureDetector(
                                                onTap: () {
                                                  item.onTap();
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30.r),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey.withOpacity(0.3),
                                                            blurRadius: 10.r,
                                                            offset: Offset(0.0,10.0)
                                                        )
                                                      ],
                                                      color: Colors.white
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        width: 65.w,
                                                        height: 65.h,
                                                        child: item.image,
                                                      ),
                                                      Text(item.name,style: TextStyle(fontFamily: FontFamily.workSans,fontSize: 18.sp,color: Colors.black))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

