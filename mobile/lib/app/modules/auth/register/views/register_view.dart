import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/constants/resources/assets.gen.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';
import 'package:angelhack_hcm/app/shared/widgets/button_container.dart';
import 'package:angelhack_hcm/app/shared/widgets/forms/form_wrapper.dart';
import 'package:angelhack_hcm/app/shared/widgets/forms/text_field.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/keyboard_dismisser.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/svg_asset.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: ColoredBox(
        color: Theme.of(context).colorScheme.onInverseSurface,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              localeLang.alreadyHaveAnAccount,
              style: $r.styles.pMedium.copyWith(
                fontSize: 12.sp,
                color: $r.theme.grey,
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.only(left: 4),
              onPressed: () => controller.toSignIn(),
              child: Text(
                localeLang.login,
                style: $r.styles.pMedium.copyWith(
                  fontSize: 12.sp,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: KeyboardDismisser(
          child: AppFormWrapper(
            formKey: controller.formKey,
            child: Stack(
              children: [
                //* Background Curved
                Container(
                  width: width,
                  height: height / 4,
                  color: Theme.of(context).colorScheme.primary,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: [
                          SvgAsset(
                            height: height,
                            width: constraints.maxWidth,
                            Assets.svgs.backgroundPattern.path,
                          ),
                          ColoredBox(
                            color: $r.theme.transparent,
                            child: Center(
                              child: Text(
                                'AngelHack HCM',
                                style: $r.styles.pBold.copyWith(
                                  fontSize: 24.sp,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: width,
                      height: height / 5,
                    ),
                    Expanded(
                      child: Container(
                        height: 0.7.sh,
                        width: width.sw,
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 32,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onInverseSurface,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(32).r,
                            topRight: const Radius.circular(32).r,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Text(
                                localeLang.signUp,
                                textAlign: TextAlign.start,
                                style: $r.styles.pBold.copyWith(
                                  fontSize: 24,
                                  color: $r.theme.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: height.h,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SingleChildScrollView(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        physics: const ClampingScrollPhysics(),
                                        child: Column(
                                          children: [
                                            //* Username
                                            AppTextField(
                                              name: 'username',
                                              formKey: controller.formKey,
                                              title: localeLang.username,
                                              labelText:
                                                  localeLang.enterYourUsername,
                                              prefixIcon:
                                                  FluentIcons.person_20_regular,
                                              // validator: AppValidator.required,
                                              keyBoardType: TextInputType.text,
                                              onChanged: (value) =>
                                                  controller.markFieldFilled(
                                                'username',
                                              ),
                                            ),
                                            const Gap(8),

                                            //* Password
                                            Obx(
                                              () => AppTextField(
                                                name: 'password',
                                                formKey: controller.formKey,
                                                title: localeLang.password,
                                                keyBoardType: TextInputType
                                                    .visiblePassword,
                                                labelText: localeLang
                                                    .enterYourPassword,
                                                prefixIcon: FluentIcons
                                                    .lock_closed_20_regular,
                                                isPwd: !controller
                                                    .showPassword.value,
                                                suffixIcon: controller
                                                        .showPassword.value
                                                    ? FluentIcons.eye_20_regular
                                                    : FluentIcons
                                                        .eye_off_20_regular,
                                                onSuffixIconTap: () =>
                                                    controller.passwordShown,
                                                // validator:
                                                //     AppValidator.required,
                                                inputAction:
                                                    TextInputAction.done,
                                                onChanged: (value) =>
                                                    controller.markFieldFilled(
                                                  'password',
                                                ),
                                              ),
                                            ),
                                            const Gap(8),

                                            //* Email
                                            AppTextField(
                                              name: 'email',
                                              formKey: controller.formKey,
                                              title: localeLang.email,
                                              labelText:
                                                  localeLang.enterYourEmail,
                                              prefixIcon:
                                                  FluentIcons.mail_20_regular,
                                              keyBoardType:
                                                  TextInputType.emailAddress,
                                              // validator: AppValidator.required,
                                              onChanged: (value) =>
                                                  controller.markFieldFilled(
                                                'email',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //* Login Button
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => ButtonContainer(
                                      isDisabled: controller.isLoading.value ||
                                          !controller.allFieldsFilled,
                                      status: controller.isLoading.value,
                                      text: localeLang.register,
                                      start: 32,
                                      end: 32,
                                      bottom: 24.h,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      textColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      borderColor:
                                          Theme.of(context).colorScheme.primary,
                                      onPressed: () => controller.onRegister(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
