import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'f_line_chart.dart';

class FCandleChart extends CustomPainter {
  double min;
  double max;
  List<ChartData> dataList;
  FCandleChart({required this.min, required this.max, required this.dataList});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path();

    // 取出最大最小值，用于归一化映射
    // final minY = dataList.map((e) => e.latest).reduce(min);
    // final maxY = dataList.map((e) => e.latest).reduce(max);

    for (int i = 0; i < dataList.length; i++) {
      final item = dataList[i];

      // x 坐标：按索引分布在宽度内
      final x = size.width / (dataList.length - 1) * i;

      // y 坐标：将价格映射到画布高度（反转 Y 轴）
      final y = size.height - ((item.latest - min) / (max - min)) * size.height;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
