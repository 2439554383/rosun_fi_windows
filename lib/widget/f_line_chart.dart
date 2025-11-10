import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FLineChart extends CustomPainter {
  double min;
  double max;
  List<ChartData> dataList;
  FLineChart({required this.min, required this.max,required this.dataList});

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
      final y = size.height -
          ((item.latest - min) / (max - min)) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      }
      else if( i == (dataList.length -1)){
        final x = i == dataList.length - 1
            ? size.width
            : size.width / (dataList.length - 1) * i;
        path.lineTo(x, y);
        // canvas.drawCircle(Offset(x, y), radius.r, paint);
      }
      else {
        path.lineTo(x, y);
      }

    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}

class ChartData {
  final double date;
  final double latest;
  final int volume;

  ChartData(this.date, this.latest, this.volume);
}