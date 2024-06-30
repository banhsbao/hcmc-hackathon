import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:angelhack_hcm/amplifyconfiguration.dart';
import 'package:angelhack_hcm/app/data/di.dart';

Future<void> configureAmplify() async {
  try {
    await Amplify.addPlugins([
      AmplifyAuthCognito(),
      AmplifyAPI(),
    ]);

    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException {
    $log.e('Amplify configuration failed.');
  } on AmplifyException catch (e) {
    $log.e('An error occurred configuring Amplify: $e');
  }
}
