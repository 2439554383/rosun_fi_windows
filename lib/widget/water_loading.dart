import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class CustomLiquidProgressIndicator extends StatefulWidget {
  const CustomLiquidProgressIndicator({super.key});

  @override
  State<CustomLiquidProgressIndicator> createState() =>
      _CustomLiquidProgressIndicatorState();
}

class _CustomLiquidProgressIndicatorState
    extends State<CustomLiquidProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: LiquidCircularProgressIndicator(
        value: 0.5,
        valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
        backgroundColor: Theme.of(context).colorScheme.surface,
        borderColor: Colors.transparent,
        borderWidth: 0,
        direction: Axis.vertical,
        center:  Text(
            "Loading...",
            style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
