import 'package:get/get.dart';

import '../../chat/controllers/chat_controller.dart';
import '../../map_gps/controllers/map_gps_controller.dart';
import '../../notification/controllers/notification_controller.dart';
import '../controllers/homepage_controller.dart';

class HomepageBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<HomepageController>(
        () => HomepageController(),
      )
      ..lazyPut<ChatController>(
        () => ChatController(),
      )
      ..lazyPut<NotificationController>(
        () => NotificationController(),
      )
      ..lazyPut<MapGpsController>(
        () => MapGpsController(),
      );
  }
}
