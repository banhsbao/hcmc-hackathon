import 'package:get/get.dart';

import '../../register/controllers/register_controller.dart';
import '../controllers/verification_controller.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<VerificationController>(
        () => VerificationController(),
      )
      ..lazyPut<RegisterController>(
        () => RegisterController(),
      );
  }
}
