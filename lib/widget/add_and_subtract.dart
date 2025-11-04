import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rosun_fi_windows/commen/commen.dart';
import 'package:rosun_fi_windows/extension/e_String.dart';
import 'package:rosun_fi_windows/util/app_component.dart';

class AddAndSubtract extends StatefulWidget {
  TextEditingController controller;
  num growing;
  double height;
  num min;
  num max;
  AddAndSubtract({super.key,required this.height, required this.growing, required this.controller, required this.min, required this.max});

  @override
  State<AddAndSubtract> createState() => _AddAndSubtractState();
}

class _AddAndSubtractState extends State<AddAndSubtract> {

  @override
  void initState() {
    widget.controller.addListener(() {
      final number = widget.controller.text.toNum;
      if (number < widget.min) {
        widget.controller.text = widget.min.toString();
        showSnackbar("提示", "最小数量为${widget.min}");
      }
      if(number > widget.max){
        widget.controller.text = widget.max.toString();
        showSnackbar("提示", "最大数量为${widget.max}");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xffE2E2E2), width: 0.5),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.controller.text = widget.controller.text.reduce(widget.growing);
              });
            },
            child: Container(
              height: widget.height,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xffF9F9F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.remove),
            ),
          ),
          Expanded(
              child: TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入数量",
                ),
              )
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.controller.text = widget.controller.text.add(widget.growing);
              });
            },
            child: Container(
              height: widget.height,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xffF9F9F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
