// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class I10n {
  I10n();

  static I10n? _current;

  static I10n get current {
    assert(_current != null,
        'No instance of I10n was loaded. Try to initialize the I10n delegate before accessing I10n.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<I10n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = I10n();
      I10n._current = instance;

      return instance;
    });
  }

  static I10n of(BuildContext context) {
    final instance = I10n.maybeOf(context);
    assert(instance != null,
        'No instance of I10n present in the widget tree. Did you add I10n.delegate in localizationsDelegates?');
    return instance!;
  }

  static I10n? maybeOf(BuildContext context) {
    return Localizations.of<I10n>(context, I10n);
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message(
      'Welcome!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get enterYourUsername {
    return Intl.message(
      'Username',
      name: 'enterYourUsername',
      desc: '',
      args: [],
    );
  }

  /// `Your password`
  String get enterYourPassword {
    return Intl.message(
      'Your password',
      name: 'enterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot?`
  String get forgotPassword {
    return Intl.message(
      'Forgot?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clearForm {
    return Intl.message(
      'Clear',
      name: 'clearForm',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get loginFailed {
    return Intl.message(
      'Login failed',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Login success`
  String get loginSuccess {
    return Intl.message(
      'Login success',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message(
      'Remember me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Your email`
  String get enterYourEmail {
    return Intl.message(
      'Your email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Your phone`
  String get enterYourPhone {
    return Intl.message(
      'Your phone',
      name: 'enterYourPhone',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register now`
  String get registerNow {
    return Intl.message(
      'Register now',
      name: 'registerNow',
      desc: '',
      args: [],
    );
  }

  /// `Back to login`
  String get backToLogin {
    return Intl.message(
      'Back to login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Enter the verify code`
  String get verifyCode {
    return Intl.message(
      'Enter the verify code',
      name: 'verifyCode',
      desc: '',
      args: [],
    );
  }

  /// `We just send you a verify code via your email \n`
  String get weHaveSentCodeTo {
    return Intl.message(
      'We just send you a verify code via your email \n',
      name: 'weHaveSentCodeTo',
      desc: '',
      args: [],
    );
  }

  /// `Enter your code`
  String get enterYourCode {
    return Intl.message(
      'Enter your code',
      name: 'enterYourCode',
      desc: '',
      args: [],
    );
  }

  /// `Verify code will be expired after {time}`
  String expiredVerifyCode(Object time) {
    return Intl.message(
      'Verify code will be expired after $time',
      name: 'expiredVerifyCode',
      desc: '',
      args: [time],
    );
  }

  /// `Resend code`
  String get resentCode {
    return Intl.message(
      'Resend code',
      name: 'resentCode',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get beforeLogout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'beforeLogout',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get required {
    return Intl.message(
      'This field is required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Email is invalid`
  String get emailInvalid {
    return Intl.message(
      'Email is invalid',
      name: 'emailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is invalid`
  String get phoneInvalid {
    return Intl.message(
      'Phone number is invalid',
      name: 'phoneInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Password is invalid`
  String get passwordInvalid {
    return Intl.message(
      'Password is invalid',
      name: 'passwordInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Password not match`
  String get passwordNotMatch {
    return Intl.message(
      'Password not match',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Double tap to exit`
  String get doubleTabToExit {
    return Intl.message(
      'Double tap to exit',
      name: 'doubleTabToExit',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try again later`
  String get somethingWentWrongAgain {
    return Intl.message(
      'Something went wrong, please try again later',
      name: 'somethingWentWrongAgain',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message(
      'Try again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Me`
  String get me {
    return Intl.message(
      'Me',
      name: 'me',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `seconds ago`
  String get secondsAgo {
    return Intl.message(
      'seconds ago',
      name: 'secondsAgo',
      desc: '',
      args: [],
    );
  }

  /// `minutes ago`
  String get minutesAgo {
    return Intl.message(
      'minutes ago',
      name: 'minutesAgo',
      desc: '',
      args: [],
    );
  }

  /// `hours ago`
  String get hoursAgo {
    return Intl.message(
      'hours ago',
      name: 'hoursAgo',
      desc: '',
      args: [],
    );
  }

  /// `days ago`
  String get daysAgo {
    return Intl.message(
      'days ago',
      name: 'daysAgo',
      desc: '',
      args: [],
    );
  }

  /// `weeks ago`
  String get weeksAgo {
    return Intl.message(
      'weeks ago',
      name: 'weeksAgo',
      desc: '',
      args: [],
    );
  }

  /// `No notification found!`
  String get emptyNotification {
    return Intl.message(
      'No notification found!',
      name: 'emptyNotification',
      desc: '',
      args: [],
    );
  }

  /// `No chat found!`
  String get emptyChat {
    return Intl.message(
      'No chat found!',
      name: 'emptyChat',
      desc: '',
      args: [],
    );
  }

  /// `No map found!`
  String get emptyMap {
    return Intl.message(
      'No map found!',
      name: 'emptyMap',
      desc: '',
      args: [],
    );
  }

  /// `Current location`
  String get currentLocation {
    return Intl.message(
      'Current location',
      name: 'currentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Search location`
  String get searchLocation {
    return Intl.message(
      'Search location',
      name: 'searchLocation',
      desc: '',
      args: [],
    );
  }

  /// `pH`
  String get pH {
    return Intl.message(
      'pH',
      name: 'pH',
      desc: '',
      args: [],
    );
  }

  /// `TDS`
  String get TDS {
    return Intl.message(
      'TDS',
      name: 'TDS',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<I10n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<I10n> load(Locale locale) => I10n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
