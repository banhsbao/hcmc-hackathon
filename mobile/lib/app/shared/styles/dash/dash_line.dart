import 'package:flutter/material.dart';

import 'package:angelhack_hcm/app/data/di.dart';

/// Dash Line View
class DashLineView extends StatelessWidget {
  final double dashHeight;
  final double dashWidth;
  final Color? dashColor;
  final double fillRate; // [0, 1] totalDashSpace/totalSpace
  final Axis direction;

  const DashLineView({
    super.key,
    this.dashHeight = 0.5,
    this.dashWidth = 5,
    this.fillRate = 0.5,
    this.direction = Axis.horizontal,
    this.dashColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxSize = direction == Axis.horizontal
            ? constraints.constrainWidth()
            : constraints.constrainHeight();
        final dCount = (boxSize * fillRate / dashWidth).floor();

        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: direction,
          children: List.generate(
            dCount,
            (_) => SizedBox(
              width: direction == Axis.horizontal ? dashWidth : dashHeight,
              height: direction == Axis.horizontal ? dashHeight : dashWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: dashColor ?? $r.theme.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
