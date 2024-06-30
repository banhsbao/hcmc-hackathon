import 'package:flutter/material.dart';

import 'base_controller.dart';
import 'base_view.dart';

abstract class BaseSilverView<Controller extends BaseController>
    extends BaseView<Controller> {
  const BaseSilverView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;
}
