import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosun_fi_windows/model/status/status_item.dart';

class SelectionButton extends StatefulWidget {
  List<StatusItem> statusList;
  double radius;
  Color color;
  EdgeInsets? padding;
  TextStyle? textStyle;
  bool shrinkWrap;
  Function callBack;
  SelectionButton({
    super.key,
    required this.statusList,
    this.radius = 8,
    this.color = Colors.white,
    this.padding,
    this.textStyle,
    this.shrinkWrap = false,
    required this.callBack,
  });

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        shrinkWrap: widget.shrinkWrap,
        itemCount: widget.statusList.length,
        itemBuilder: (context, index) {
          final item = widget.statusList[index];
          return GestureDetector(
            onTap: () {
              widget.callBack(index);
            },
            child: Center(
              child: Container(
                width: 50.w,
                height: 50.h,
                padding: widget.padding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  color: widget.color,
                  border: Border.all(
                    color: item.status ? Colors.deepPurple : Colors.transparent,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(item.name, style: widget.textStyle),
              ),
            ),
          );
        },
      ),
    );
  }
}
