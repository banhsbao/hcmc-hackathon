import 'package:get/get.dart';

import '../../login/controllers/login_controller.dart';
import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<RegisterController>(
        () => RegisterController(),
      )
      ..lazyPut<LoginController>(
        () => LoginController(),
      );
  }
}
