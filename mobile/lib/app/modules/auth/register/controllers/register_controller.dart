import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/routes/app_pages.dart';
import 'package:angelhack_hcm/app/shared/constants/enums/systems.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';
import 'package:angelhack_hcm/app/shared/utils/utils.dart';
import 'package:angelhack_hcm/app/shared/widgets/base/base_controller.dart';

class RegisterController extends BaseController {
  //* Variables
  RxBool showPassword = false.obs, rememberPwd = false.obs;
  RxString errorMessage = ''.obs;
  final Map<String, RxBool> fieldStatus = {
    'username': false.obs,
    'password': false.obs,
    'email': false.obs,
  };

  //* Getters
  GlobalKey<FormBuilderState> get formKey => $r.keys.registerFormKey;
  bool get passwordShown => showPassword.value = !showPassword.value;
  bool get allFieldsFilled => fieldStatus.values.every((e) => e.value);

  //* Methods
  void markFieldFilled(String? fieldName) {
    final String field = formKey.currentState?.fields[fieldName]?.value ?? '';
    fieldStatus[fieldName]?.value = field.isNotEmpty;
  }

  void updateErrorMessage(String? value) {
    errorMessage.value = '';
    if (value == null) return;
    final output = value.trim().obs;
    errorMessage = output.isNotEmpty ? output : ''.obs;
  }

  Future<void> onRegister() async {
    FocusScope.of(gContext).requestFocus(FocusNode());
    updateErrorMessage('');

    //* Validate form
    final formKey = $r.keys.registerFormKey.currentState;
    if (!formKey!.validate()) return;

    showLoading();

    try {
      final result = await Amplify.Auth.signUp(
        username: formKey.fields['username']?.value.trim() ?? '',
        password: formKey.fields['password']?.value.trim() ?? '',
        options: SignUpOptions(
          userAttributes: {
            AuthUserAttributeKey.email:
                formKey.fields['email']?.value.trim() ?? '',
          },
        ),
      );
      await handleSignUpResult(
        result,
        formKey.fields['username']?.value.trim() ?? '',
      );
    } on AuthException catch (e) {
      await AppUtils.showSnackBar(
        message: e.message,
        type: SnackBarType.error,
      );
    } finally {
      hideLoading();
    }
  }

  Future<void> handleSignUpResult(SignUpResult result, String username) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        await handleCodeDelivery(codeDeliveryDetails, username);
      case AuthSignUpStep.done:
        await Get.offNamed(Routes.LOGIN);
    }
  }

  Future<void> handleCodeDelivery(
    AuthCodeDeliveryDetails codeDeliveryDetails,
    String username,
  ) async {
    try {
      await Get.toNamed(
        Routes.VERIFICATION,
        arguments: {'email': username},
      );
    } catch (e) {
      safePrint(
        'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
        'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
      );
      $log.e(localeLang.somethingWentWrongAgain);
    }
  }

  Future<void> toSignIn() async {
    await Get.offNamed(Routes.LOGIN);
  }
}
