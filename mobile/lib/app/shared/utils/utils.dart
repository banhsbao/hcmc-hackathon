import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ndialog/ndialog.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/constants/enums/systems.dart';
import 'package:angelhack_hcm/app/shared/constants/resources/assets.gen.dart';
import 'package:angelhack_hcm/app/shared/utils/helpers/misc.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';
import 'package:angelhack_hcm/app/shared/widgets/small_button_container.dart';

/// Self-signed certificate
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

/// Global scroll behavior
class GlobalScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

/// Utilities
class AppUtils {
  //* Snackbars
  static Future<void> showSnackBar({
    required String message,
    SnackBarType type = SnackBarType.success,
  }) async {
    final snackBar = _createSnackBar(message, type: type);
    Get.showSnackbar(snackBar);
  }

  //* Methods
  static GetSnackBar _createSnackBar(
    String message, {
    SnackBarType type = SnackBarType.success,
  }) {
    return GetSnackBar(
      messageText: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            type == SnackBarType.error
                ? FluentIcons.error_circle_20_regular
                : type == SnackBarType.warning
                    ? FluentIcons.warning_20_regular
                    : type == SnackBarType.info
                        ? FluentIcons.info_20_regular
                        : FluentIcons.checkmark_circle_24_regular,
            color: Theme.of(gContext).colorScheme.onPrimary,
            size: 20,
          ),
          const Gap(12),
          Expanded(
            child: Text(
              message,
              overflow: TextOverflow.ellipsis,
              style: $r.styles.pRegular.copyWith(
                fontSize: 12.sp,
                color: Theme.of(gContext).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: height * 0.03, right: 24, left: 24),
      backgroundColor: type == SnackBarType.error
          ? Theme.of(gContext).colorScheme.error
          : type == SnackBarType.warning
              ? $r.theme.warning
              : type == SnackBarType.info
                  ? $r.theme.black
                  : $r.theme.success,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      borderRadius: 8,
      duration: $r.times.slow,
    );
  }

  static String parseToCorrectTime(String time) {
    final parts = time.split('-');
    final year = parts[0];
    final month = parts[1];
    final day = parts[2];
    return '$day/$month/$year';
  }

  //* Dialogs
  static Future<void> showDialog(
    String? title,
    String? message, {
    int? displayTime,
    String? imagePath,
    bool isError = false,
  }) async {
    imagePath = imagePath ?? Assets.animations.confirm.path;
    final timer = Timer(
      $r.times.threeSeconds,
      () => Get
        ..back()
        ..back(),
    );

    await Get.dialog(
      NDialog(
        dialogStyle: DialogStyle(titleDivider: true),
        title: Text(
          isTitleEmpty(title),
          textAlign: TextAlign.center,
          style: $r.styles.pSemiBold.copyWith(
            color: isError
                ? Theme.of(gContext).colorScheme.error
                : $r.theme.success,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              imagePath,
              height: 180,
              width: 180,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                isTitleEmpty(message),
                textAlign: TextAlign.center,
                style: $r.styles.pMedium.copyWith(
                  color: $r.theme.black,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        actions: [
          SmallButtonContainer(
            marginRight: 20,
            marginLeft: 20,
            color: Theme.of(gContext).colorScheme.primary,
            text: localeLang.ok,
            radius: 8,
            borderColor:
                Theme.of(gContext).colorScheme.primary.withOpacity(0.10),
            textColor: Theme.of(gContext).colorScheme.onPrimary,
            onTap: () => Get
              ..back()
              ..back(),
          ),
        ],
      ),
    ).then((value) {
      if (timer.isActive) timer.cancel();
    });
  }
}
