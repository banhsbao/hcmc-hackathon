import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../utils/ui_utils.dart';

class LoadingSpinner extends StatelessWidget {
  final Color? color;
  final double? size;

  const LoadingSpinner({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.fourRotatingDots(
      color: color ?? Theme.of(gContext).colorScheme.primary,
      size: size ?? 50,
    );
  }
}
