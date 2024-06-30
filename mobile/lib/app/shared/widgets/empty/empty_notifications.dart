import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/constants/resources/assets.gen.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';

class EmptyNotifications extends StatelessWidget {
  const EmptyNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: height / 1.5,
          width: width,
          padding: const EdgeInsets.all(24),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Lottie.asset(
                Assets.animations.noNotificationFound.path,
                height: height / 0.8,
                width: height / 0.8,
                fit: BoxFit.contain,
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: height / 12,
                child: Text(
                  localeLang.emptyNotification,
                  textAlign: TextAlign.center,
                  style: $r.styles.pMedium.copyWith(
                    fontSize: 16.sp,
                    color: $r.theme.grey1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
