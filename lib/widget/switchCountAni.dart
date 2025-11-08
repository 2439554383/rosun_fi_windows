import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

class AnimatedFlipper extends StatefulWidget {
  const AnimatedFlipper({super.key});

  @override
  State<AnimatedFlipper> createState() => _AnimatedFlipperState();
}

class _AnimatedFlipperState extends State<AnimatedFlipper> {
  late StreamController _valueStream = StreamController();
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        i++;
        _valueStream.add(i);
      },
      behavior: HitTestBehavior.opaque,
      child: StreamBuilder(
        stream: _valueStream.stream,
        initialData: 0,
        builder: (context, snapshot) {
          final value = snapshot.data ?? 0;
          return AnimatedFlipCounter(
            value: value,
            fractionDigits: 2,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            textStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: value >= 0 ? Colors.green : Colors.red,
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // _valueStream =
    //     Stream.periodic(const Duration(seconds: 2), (count) => count);
  }
}
