import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:angelhack_hcm/app/shared/widgets/base/base_controller.dart';
import 'package:get/get.dart';

import '../../register/controllers/register_controller.dart';

class VerificationController extends BaseController {
  //* Dependencies
  final registerCtrl = Get.find<RegisterController>();

  //* Variables
  RxString username = ''.obs, confirmationCode = ''.obs;
  Timer? timer;
  RxInt start = 10.obs;

  //* Getters
  late final dynamic args = Get.arguments;

  //* Init
  @override
  Future<void> onInit() async {
    super.onInit();
    await onInitData();
    startTimer();
  }

  //* Methods
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (timer) {
        if (start.value == 0) {
          timer.cancel();
        } else {
          start--;
        }
      },
    );
  }

  Future<void> onInitData() async {
    username.value = args['email'];
  }

  Future<void> backToSignUp() async {
    Get.back();
  }

  Future<void> confirmUser({
    required String username,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
      await registerCtrl.handleSignUpResult(result, username);
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
    }
  }
}
