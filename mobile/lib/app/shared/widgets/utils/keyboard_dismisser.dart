import 'package:flutter/material.dart';

class KeyboardDismisser extends StatelessWidget {
  final Widget child;

  const KeyboardDismisser({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
