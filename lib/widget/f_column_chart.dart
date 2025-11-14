import 'package:flutter/material.dart';

class FColumnChartView extends StatelessWidget {
  const FColumnChartView({
    super.key,
    required this.min,
    required this.max,
    required this.barWidth,
    required this.dataList,
    this.height = 75,
    this.isScroll = false,
    this.spacing,
  });

  final double min;
  final double max;
  final double barWidth;
  final double height;
  final List<dynamic> dataList;
  final bool isScroll;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    final double effectiveSpacing = spacing ?? (isScroll ? barWidth * 0.6 : 0);
    final double totalWidth = isScroll
        ? (dataList.isEmpty
              ? barWidth
              : dataList.length * (barWidth + effectiveSpacing))
        : 0;

    final Widget chart = SizedBox(
      width: isScroll ? totalWidth : null,
      height: height,
      child: CustomPaint(
        painter: FColumnChart(
          min: min,
          max: max,
          width: barWidth,
          dataList: dataList,
          isScroll: isScroll,
          spacing: effectiveSpacing,
        ),
      ),
    );

    if (!isScroll) {
      return chart;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: chart,
    );
  }
}

class FColumnChart extends CustomPainter {
  FColumnChart({
    required this.min,
    required this.max,
    required this.width,
    required this.dataList,
    this.isScroll = false,
    this.spacing = 0,
  });

  final double min;
  final double max;
  final double width;
  final List<dynamic> dataList;
  final bool isScroll;
  final double spacing;

  @override
  void paint(Canvas canvas, Size size) {
    if (dataList.isEmpty) {
      return;
    }

    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    final int length = dataList.length;
    final double denominator = length > 1 ? (length - 1).toDouble() : 1;
    final double step = isScroll ? width + spacing : size.width / denominator;
    final double halfBar = width / 2;
    final double valueRange = (max - min).abs() < 1e-6 ? 1 : (max - min);

    for (int i = 0; i < length; i++) {
      final dynamic item = dataList[i];
      final double volume = item.volume?.toDouble() ?? 0;

      final double x = isScroll ? i * step + halfBar : step * i;
      final double normalized = (volume - min) / valueRange;
      final double y = size.height - normalized * size.height;

      canvas.drawLine(Offset(x, size.height), Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
