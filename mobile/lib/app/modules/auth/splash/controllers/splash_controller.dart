import 'package:flutter/services.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../../data/di.dart';
import '../../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  Future<void> initData() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
    await Future.delayed($r.times.twoSeconds);

    final isSignedIn = await isUserSignedIn();
    if (isSignedIn) {
      final deviceToken = await FirebaseMessaging.instance.getToken() ?? '';
      $log.i(deviceToken);

      await Get.offNamed(
        Routes.HOMEPAGE,
        arguments: {
          'currentLocation': await $location.getPosition(),
        },
      );
    } else {
      await Get.offNamed(Routes.LOGIN);
    }
  }
}
