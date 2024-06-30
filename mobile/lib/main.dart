import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'app/data/di.dart';
import 'app/shared/utils/utils.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      HttpOverrides.global = MyHttpOverrides();

      await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
      );

      await $log.initLogger();
      await $notification.initNotification();

      runApp(const MyApp());
    },
    (error, stackTrace) => $log.handle(error, stackTrace),
  );
}
