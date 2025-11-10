import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'f_line_chart.dart';

class FColumnChart extends CustomPainter {
  double min;
  double max;
  List<ChartData> dataList;
  FColumnChart({required this.min, required this.max,required this.dataList});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < dataList.length; i++) {
      final item = dataList[i];

      // x 坐标：按索引分布在宽度内
      final x = size.width / (dataList.length - 1) * i;

      // y 坐标：将价格映射到画布高度（反转 Y 轴）
      final y = size.height -
          ((item.volume - min) / (max - min)) * size.height;

      canvas.drawLine(Offset(x, size.height), Offset(x, y),paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}
