import 'package:get/get.dart';

import 'package:angelhack_hcm/app/data/repositories/node.repo.dart';
import 'package:angelhack_hcm/app/data/repositories/notification.repo.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get
      ..lazyPut(NodeRepository.new)
      ..lazyPut(NotificationRepository.new);
  }
}
