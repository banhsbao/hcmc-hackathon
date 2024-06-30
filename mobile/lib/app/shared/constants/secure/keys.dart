import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

@immutable
class AppFormKeys {
  final loginFormKey = GlobalKey<FormBuilderState>();
  final registerFormKey = GlobalKey<FormBuilderState>();
  final profileFormKey = GlobalKey<FormBuilderState>();
  final passwordFormKey = GlobalKey<FormBuilderState>();
}
