import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

class AppFormWrapper extends StatefulWidget {
  final Widget child;
  final GlobalKey<FormBuilderState> formKey;
  final VoidCallback? onChanged;

  const AppFormWrapper({
    required this.formKey,
    required this.child,
    super.key,
    this.onChanged,
  });

  @override
  State<AppFormWrapper> createState() => _AppFormWrapperState();
}

class _AppFormWrapperState extends State<AppFormWrapper> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      onChanged: () {
        widget.formKey.currentState!.save();
        if (widget.onChanged != null) widget.onChanged?.call();
      },
      child: widget.child,
    );
  }
}
