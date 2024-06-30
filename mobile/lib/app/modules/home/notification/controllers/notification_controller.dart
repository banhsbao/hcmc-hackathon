import 'package:angelhack_hcm/app/data/repositories/notification.repo.dart';
import 'package:angelhack_hcm/app/shared/utils/helpers/misc.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:angelhack_hcm/app/shared/widgets/base/base_controller.dart';

import '../../homepage/controllers/homepage_controller.dart';

class NotificationController extends BaseController {
  //* Dependencies
  final homeController = Get.find<HomepageController>();
  final notificationController = Get.find<NotificationRepository>();

  //* Variables
  final notifications = [].obs;
  final hasReadAll = false.obs;
  final pagingController = PagingController(firstPageKey: 0);

  //* Getters
  bool get hasNotification => notifications.isNotEmpty;
  bool get hasReadAllNotification => hasReadAll.value;

  //* Methods
  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) => fetchData(pageKey));
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future<void> fetchData(int pageKey, {int pageSize = 20}) async {
    try {
      final res = await notificationController.getUserNotifications();
      final pages = res.chunked(pageSize).toList();
      final isLastPage = pages.length <= pageKey + 1;
      if (isLastPage) {
        pagingController.appendLastPage(pages[pageKey]);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(pages[pageKey], nextPageKey);
      }
    } catch (e) {
      pagingController.error = e;
    }
  }

  Future<void> onRefresh() async {
    pagingController.refresh();
  }
}
