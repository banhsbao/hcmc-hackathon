import 'package:flutter/material.dart';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:angelhack_hcm/app/data/di.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      duration: $r.times.oneSeconds,
      animationDuration: $r.times.med,
      backgroundColor: $r.theme.white,
      childWidget: Text(
        'AngelHack HCM',
        style: $r.styles.pBold.copyWith(
          fontSize: 24.sp,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
