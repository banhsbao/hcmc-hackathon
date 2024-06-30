import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:angelhack_hcm/app/data/binding.dart';
import 'package:angelhack_hcm/app/shared/localization/generated/l10n.dart';

import 'app/data/di.dart';
import 'app/routes/app_pages.dart';
import 'app/shared/utils/amplify.dart';
import 'app/shared/utils/utils.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    configureAmplify();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(_) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: $r.theme.transparent,
        systemNavigationBarColor: $r.theme.white,
      ),
      child: ScreenUtilInit(
        minTextAdapt: true,
        builder: (_, child) => Authenticator(
          child: GetMaterialApp(
            useInheritedMediaQuery: true,
            theme: $r.defaultTheme,
            navigatorKey: Get.key,
            transitionDuration: $r.times.pageTransition,
            debugShowCheckedModeBanner: false,
            builder: (context, widget) => ScrollConfiguration(
              behavior: GlobalScrollBehavior(),
              child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.noScaling),
                child: widget!,
              ),
            ),
            locale: $r.defaultLocale,
            fallbackLocale: $r.alternativeLocale,
            localizationsDelegates: const [
              I10n.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: I10n.delegate.supportedLocales,
            localeResolutionCallback: (deviceLocale, supportedLocales) =>
                supportedLocales
                        .map((e) => e.languageCode)
                        .contains(deviceLocale?.languageCode)
                    ? deviceLocale
                    : $r.defaultLocale,
            getPages: AppPages.routes,
            initialRoute: AppPages.INITIAL,
            initialBinding: AppBinding(),
          ),
        ),
      ),
    );
  }
}
