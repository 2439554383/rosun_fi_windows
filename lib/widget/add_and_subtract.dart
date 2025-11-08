import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rosun_fi_windows/commen/commen.dart';
import 'package:rosun_fi_windows/extension/e_String.dart';

class AddAndSubtract extends StatefulWidget {
  TextEditingController controller;
  num growing;
  double height;
  double radius;
  num min;
  num max;
  Color? borderColor;
  Type? type;
  AddAndSubtract({super.key,required this.height, required this.growing, required this.controller, required this.min, required this.max,this.borderColor=Colors.white,this.type=Type.separate,this.radius=10});

  @override
  State<AddAndSubtract> createState() => _AddAndSubtractState();
}

enum Type {
  separate,
  connect
}

class _AddAndSubtractState extends State<AddAndSubtract> {
  double reduceIconSize = 25.sp;
  double addIconSize = 25.sp;
  Key _animationKey = UniqueKey();

  @override
  void initState() {
    widget.controller.addListener(() {
      final number = widget.controller.text.toNum;
      if (number < widget.min) {
        // widget.controller.text = widget.min.toString();
        showSnackbar("提示", "最小数量为${widget.min}");
      }
      if(number > widget.max){
        // widget.controller.text = widget.max.toString();
        showSnackbar("提示", "最大数量为${widget.max}");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.type == Type.separate) {
      return Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 65.w,
              height: widget.height,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(widget.radius),
              ),
              clipBehavior: Clip.hardEdge,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.controller.text = widget.controller.text.reduce(widget.growing);
                      reduceIconSize = 40.sp;
                    });
                    Future.delayed(Duration(milliseconds: 100),(){
                      setState(() {
                        reduceIconSize = 25.sp;
                      });
                    });
                  },
                  splashFactory: InkSparkle.splashFactory,
                  splashColor: Colors.blueAccent,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 25.sp, end: reduceIconSize),
                    duration: Duration(milliseconds: 100),
                    builder: (context, size, child) {
                      return Icon(Icons.remove, size: size,color: Colors.white,);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 5.w,),
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(widget.radius)
                  ),
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w500),
                    textAlignVertical: TextAlignVertical.center,
                    controller: widget.controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "请输入数量",
                      contentPadding: EdgeInsets.zero
                    ),
                  ),
                )
            ),
            SizedBox(width: 5.w,),
            Container(
              width: 65.w,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.borderColor,
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(widget.radius),
              ),
              clipBehavior: Clip.hardEdge,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.controller.text = widget.controller.text.reduce(widget.growing);
                      addIconSize = 30.sp;
                    });
                    Future.delayed(Duration(milliseconds: 300),(){
                      setState(() {
                        addIconSize = 25.sp;
                      });
                    });
                  },
                  splashFactory: InkSparkle.splashFactory,
                  splashColor: Colors.blueAccent,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 25.sp, end: addIconSize),
                    duration: Duration(milliseconds: 300),
                    builder: (context, size, child) {
                      return Icon(Icons.add, size: size,color: Colors.white,);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    if(widget.type == Type.connect) {
      return Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(widget.radius)
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 65.w,
              height: widget.height,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              clipBehavior: Clip.hardEdge,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.controller.text = widget.controller.text.reduce(widget.growing);
                      reduceIconSize = 40.sp;
                    });
                    Future.delayed(Duration(milliseconds: 100),(){
                      setState(() {
                        reduceIconSize = 25.sp;
                      });
                    });
                  },
                  splashFactory: InkSparkle.splashFactory,
                  splashColor: Colors.blueAccent,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 25.sp, end: reduceIconSize),
                    duration: Duration(milliseconds: 100),
                    builder: (context, size, child) {
                      return Icon(Icons.remove, size: size,color: Colors.white,);
                    },
                  ),
                ),
              ),
            ),
            Container(width: 1.w,color: Colors.blueAccent,),
            SizedBox(width: 5.w,),
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(widget.radius)
                  ),
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w500),
                    textAlignVertical: TextAlignVertical.center,
                    controller: widget.controller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "请输入数量",
                        contentPadding: EdgeInsets.zero
                    ),
                  ),
                )
            ),
            SizedBox(width: 5.w,),
            Container(width: 1.w,color: Colors.blueAccent,),
            Container(
              width: 65.w,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.borderColor,
              ),
              clipBehavior: Clip.hardEdge,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.controller.text = widget.controller.text.reduce(widget.growing);
                      addIconSize = 30.sp;
                    });
                    Future.delayed(Duration(milliseconds: 300),(){
                      setState(() {
                        addIconSize = 25.sp;
                      });
                    });
                  },
                  splashFactory: InkSparkle.splashFactory,
                  splashColor: Colors.blueAccent,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 25.sp, end: addIconSize),
                    duration: Duration(milliseconds: 300),
                    builder: (context, size, child) {
                      return Icon(Icons.add, size: size,color: Colors.white,);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 65.w,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            clipBehavior: Clip.hardEdge,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.controller.text = widget.controller.text.reduce(widget.growing);
                    reduceIconSize = 40.sp;
                  });
                  Future.delayed(Duration(milliseconds: 100),(){
                    setState(() {
                      reduceIconSize = 25.sp;
                    });
                  });
                },
                splashFactory: InkSparkle.splashFactory,
                splashColor: Colors.blueAccent,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 25.sp, end: reduceIconSize),
                  duration: Duration(milliseconds: 100),
                  builder: (context, size, child) {
                    return Icon(Icons.remove, size: size,color: Colors.white,);
                  },
                ),
              ),
            ),
          ),
          SizedBox(width: 5.w,),
          Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(widget.radius)
                ),
                child: TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w500),
                  textAlignVertical: TextAlignVertical.center,
                  controller: widget.controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "请输入数量",
                      contentPadding: EdgeInsets.zero
                  ),
                ),
              )
          ),
          SizedBox(width: 5.w,),
          Container(
            width: 65.w,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.borderColor,
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            clipBehavior: Clip.hardEdge,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.controller.text = widget.controller.text.reduce(widget.growing);
                    addIconSize = 30.sp;
                  });
                  Future.delayed(Duration(milliseconds: 300),(){
                    setState(() {
                      addIconSize = 25.sp;
                    });
                  });
                },
                splashFactory: InkSparkle.splashFactory,
                splashColor: Colors.blueAccent,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 25.sp, end: addIconSize),
                  duration: Duration(milliseconds: 300),
                  builder: (context, size, child) {
                    return Icon(Icons.add, size: size,color: Colors.white,);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
