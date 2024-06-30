import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';
import 'package:angelhack_hcm/app/shared/widgets/base/base_silver_view.dart';
import 'package:angelhack_hcm/app/shared/widgets/button_container.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/custom_appbar.dart';

import '../controllers/verification_controller.dart';

class VerificationView extends BaseSilverView<VerificationController> {
  const VerificationView({super.key});

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        titleColor: Theme.of(context).colorScheme.primary,
        showTitleCenter: true,
        showLeadingBtn: true,
        showBtmShadow: true,
        leadingIcon: Icon(
          FluentIcons.ios_arrow_ltr_24_regular,
          size: 18,
          color: Theme.of(context).colorScheme.primary,
        ),
        backgroundColor: $r.theme.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localeLang.verifyCode,
                        style: $r.styles.pSemiBold.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        localeLang.weHaveSentCodeTo,
                        style: $r.styles.pRegular.copyWith(
                          fontSize: 14,
                          color: $r.theme.grey,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Pinput(
                          length: 6,
                          onChanged: (value) =>
                              controller.confirmationCode.value = value,
                          defaultPinTheme: PinTheme(
                            height: 48,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: $r.theme.grey.withOpacity(0.2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => ButtonContainer(
                                isDisabled: controller.isLoading.value,
                                status: controller.isLoading.value,
                                text: localeLang.verifyCode,
                                start: 32,
                                end: 32,
                                bottom: 24.h,
                                color: Theme.of(context).colorScheme.secondary,
                                textColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                borderColor:
                                    Theme.of(context).colorScheme.primary,
                                onPressed: () => controller.confirmUser(
                                  username: controller.username.value,
                                  confirmationCode:
                                      controller.confirmationCode.value,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => Center(
                          child: Text(
                            localeLang.expiredVerifyCode(
                              controller.start.value.toString(),
                            ),
                            style: $r.styles.pRegular.copyWith(
                              fontSize: 14,
                              color: $r.theme.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => IgnorePointer(
                          ignoring: controller.start.value != 0,
                          child: Opacity(
                            opacity: controller.start.value != 0 ? 0.5 : 1,
                            child: Center(
                              child: Text(
                                localeLang.resentCode,
                                style: $r.styles.pRegular.copyWith(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(
                                        controller.start.value != 0 ? 0.5 : 1,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
