import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';

/// Validators
class AppValidator {
  //* Validators
  static final required = FormBuilderValidators.required(
    errorText: localeLang.required,
  );

  static final email = FormBuilderValidators.compose([
    required,
    FormBuilderValidators.email(errorText: localeLang.emailInvalid),
  ]);

  static final phone = FormBuilderValidators.compose([
    required,
    FormBuilderValidators.numeric(errorText: localeLang.phoneInvalid),
    FormBuilderValidators.minLength(10, errorText: localeLang.phoneInvalid),
    FormBuilderValidators.maxLength(11, errorText: localeLang.phoneInvalid),
  ]);

  static final password = FormBuilderValidators.compose([
    required,
    FormBuilderValidators.minLength(6, errorText: localeLang.passwordInvalid),
    FormBuilderValidators.maxLength(20, errorText: localeLang.passwordInvalid),
  ]);

  static final confirmPassword = FormBuilderValidators.compose([
    password,
    (val) {
      final formKey = $r.keys.passwordFormKey.currentState!;
      if (val != null && val != formKey.fields['newPassword']?.value) {
        return localeLang.passwordNotMatch;
      }
      return null;
    },
  ]);
}
