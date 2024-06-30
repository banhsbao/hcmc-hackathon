import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../../data/di.dart';
import '../../constants/enums/systems.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({
    required this.child,
    super.key,
    this.isActive = true,
    this.baseColor,
    this.highlightColor,
    this.direction = SkeletonDirection.ltr,
    this.period = const Duration(seconds: 2),
  });

  final Color? baseColor;
  final Widget child;
  final SkeletonDirection direction;
  final Color? highlightColor;
  final bool isActive;
  final Duration period;

  ShimmerDirection getDirection(SkeletonDirection skDirection) {
    ShimmerDirection direction;
    switch (skDirection) {
      case SkeletonDirection.ltr:
        direction = ShimmerDirection.ltr;
      case SkeletonDirection.rtl:
        direction = ShimmerDirection.rtl;
      case SkeletonDirection.btt:
        direction = ShimmerDirection.btt;
      case SkeletonDirection.ttb:
        direction = ShimmerDirection.ttb;
    }

    return direction;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = $r.theme.grey;
    final shimmerDirection = getDirection(direction);

    return isActive
        ? Shimmer.fromColors(
            baseColor: baseColor ?? colorScheme.withOpacity(0.05),
            highlightColor: highlightColor ?? colorScheme.withOpacity(0.2),
            direction: shimmerDirection,
            period: period,
            child: child,
          )
        : child;
  }
}
