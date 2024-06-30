import 'package:flutter/material.dart';

import '../../../data/di.dart';

class TapSplash extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  final double radius;
  final Color? splashColor;
  final BorderRadius? customBorderRadius;

  const TapSplash({
    required this.child,
    super.key,
    this.radius = 0,
    this.onTap,
    this.splashColor,
    this.customBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: $r.theme.transparent,
      child: InkWell(
        splashColor: $r.theme.grey,
        borderRadius:
            customBorderRadius ?? BorderRadius.all(Radius.circular(radius)),
        overlayColor: WidgetStateProperty.all(
          splashColor ?? Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
        onTap: onTap,
        child: child,
      ),
    );
  }
}
