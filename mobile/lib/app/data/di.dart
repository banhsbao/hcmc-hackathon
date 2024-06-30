import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:angelhack_hcm/app/data/common/location.service.dart';
import 'package:angelhack_hcm/app/data/common/logger_service.dart';
import 'package:angelhack_hcm/app/data/common/notification_service.dart';
import 'package:angelhack_hcm/app/shared/utils/config.dart';

/// Global instances
final $r = Get.put(AppConfig());
final $log = Get.put(LoggerService());
final $network = Get.put(InternetConnection());
final $location = Get.put(LocationService());
final $notification = Get.put(NotificationService());
