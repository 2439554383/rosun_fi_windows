import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page/test/test_page.dart';
import 'f_line_chart.dart';

class TrandePoint extends CustomPainter {
  double min;
  double max;
  double radius;
  List<ChartData> dataList ;
  TrandePoint({required this.min, required this.max, required this.radius,required this.dataList});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    final path = Path();

    final lastData = dataList.last;
    final x = size.width/(dataList.length - 1)*(dataList.length-1);
    final y = size.height - (lastData.latest-min)/(max-min)*size.height;
    canvas.drawCircle(Offset(x, y), radius, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}