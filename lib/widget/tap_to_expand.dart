import 'package:flutter/material.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

class TapToExpend extends StatelessWidget {
  const TapToExpend({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: TapToExpand(
        backgroundcolor: Colors.black,
        curve: Curves.easeIn,
        content: Column(
          children: <Widget>[
            for (var i = 0; i < 20; i++)
              Text(
                "data $i",
                style: theme.textTheme.bodyLarge?.copyWith(fontSize: 20,color: Colors.white),
              ),
          ],
        ),
        title: Text(
          'TapToExpand',
          style: theme.textTheme.titleLarge?.copyWith(fontSize: 20,color: Colors.white),
        ),
        closedHeight: 70,
        borderRadius: BorderRadius.circular(10),
        openedHeight: 200,
      ),
    );
  }
}
