import 'package:get/get.dart';

import '../controllers/map_gps_controller.dart';

class MapGpsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapGpsController>(
      () => MapGpsController(),
    );
  }
}
