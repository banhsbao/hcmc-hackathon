import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/constants/resources/assets.gen.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';
import 'package:angelhack_hcm/app/shared/widgets/button_container.dart';

class ErrorNotifications extends StatelessWidget {
  final void Function()? onRetry;

  const ErrorNotifications({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Expanded(
                  child: Lottie.asset(
                    Assets.animations.noNotificationFound.path,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        localeLang.somethingWentWrongAgain,
                        textAlign: TextAlign.center,
                        style: $r.styles.pMedium.copyWith(
                          fontSize: 16.sp,
                          color: $r.theme.grey1,
                        ),
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 10,
                            child: ButtonContainer(
                              isTextBold: false,
                              prefixIcon:
                                  FluentIcons.arrow_counterclockwise_20_regular,
                              text: localeLang.tryAgain,
                              top: height / 20,
                              bottom: height / 20,
                              start: width / 12,
                              end: width / 12,
                              color: Theme.of(context).colorScheme.primary,
                              textColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              borderColor:
                                  Theme.of(context).colorScheme.primary,
                              onPressed: () => onRetry?.call(),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
