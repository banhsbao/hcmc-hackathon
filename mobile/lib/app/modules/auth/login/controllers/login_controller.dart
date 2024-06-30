import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/routes/app_pages.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';

import '../../../../shared/widgets/base/base_controller.dart';

class LoginController extends BaseController {
  //* Variables
  RxBool showPassword = false.obs, rememberPwd = false.obs;
  RxString errorMessage = ''.obs;
  final Map<String, RxBool> fieldStatus = {
    'username': false.obs,
    'password': false.obs,
  };

  //* Init
  @override
  void onClose() {
    // Clear all controllers
    errorMessage.value = '';
    showPassword.value = false;
    rememberPwd.value = false;

    // Clear all field status
    fieldStatus.forEach((key, value) => value.value = false);

    super.onClose();
  }

  //* Getters
  GlobalKey<FormBuilderState> get formKey => $r.keys.loginFormKey;
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

  Future<void> onLogin() async {
    FocusScope.of(gContext).requestFocus(FocusNode());
    updateErrorMessage('');

    //* Validate form
    final formKey = $r.keys.loginFormKey.currentState;
    if (!formKey!.validate()) return;

    showLoading();

    final deviceToken = await FirebaseMessaging.instance.getToken() ?? '';
    $log.i(deviceToken);

    try {
      final result = await Amplify.Auth.signIn(
        username: formKey.fields['username']?.value.trim() ?? '',
        password: formKey.fields['password']?.value.trim() ?? '',
      );
      await _handleSignInResult(result);
    } on AuthException catch (e) {
      updateErrorMessage(e.message);
    } finally {
      hideLoading();
    }
  }

  Future<void> _handleSignInResult(SignInResult result) async {
    final formKey = $r.keys.loginFormKey.currentState;
    if (!formKey!.validate()) return;

    switch (result.nextStep.signInStep) {
      case AuthSignInStep.confirmSignInWithSmsMfaCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);

      //
      case AuthSignInStep.confirmSignInWithNewPassword:
        safePrint('Enter a new password to continue signing in');

      //
      case AuthSignInStep.confirmSignInWithCustomChallenge:
        final parameters = result.nextStep.additionalInfo;
        final prompt = parameters['prompt']!;
        safePrint(prompt);

      //
      case AuthSignInStep.confirmSignUp:
        final resendResult = await Amplify.Auth.resendSignUpCode(
          username: formKey.fields['username']?.value.trim() ?? '',
        );
        _handleCodeDelivery(resendResult.codeDeliveryDetails);

      //
      case AuthSignInStep.done:
        safePrint('Sign in is complete');
        //
        await Get.offNamed(
          Routes.HOMEPAGE,
          arguments: {
            'currentLocation': await $location.getPosition(),
          },
        );

      //
      case AuthSignInStep.continueSignInWithMfaSelection:
      case AuthSignInStep.continueSignInWithTotpSetup:
      case AuthSignInStep.confirmSignInWithTotpMfaCode:
      case AuthSignInStep.resetPassword:
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

  Future<void> toSignUp() async {
    await Get.offNamed(Routes.REGISTER);
  }
}
