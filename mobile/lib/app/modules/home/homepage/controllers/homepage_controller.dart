import 'package:angelhack_hcm/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/modules/home/map_gps/views/map_gps_view.dart';
import 'package:angelhack_hcm/app/modules/home/notification/views/notification_view.dart';
import 'package:angelhack_hcm/app/shared/constants/enums/systems.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';
import 'package:angelhack_hcm/app/shared/utils/utils.dart';
import 'package:angelhack_hcm/app/shared/widgets/base/base_controller.dart';

class HomepageController extends BaseController
    with GetTickerProviderStateMixin {
  //* Variables
  RxInt currentTabIndex = 0.obs;
  RxBool isEnglish = false.obs,
      isSettings = false.obs,
      hasNotification = false.obs;
  DateTime? lastBackPressedTime;
  late PageController pageController;

  @override
  void onInit() {
    fetchDataLoading(() => getInAppSystem());
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  //* Navigation
  final tabs = [
    HomeTabInfo(
      title: localeLang.map,
      icon: HeroIcons.globeAsiaAustralia,
      iconSize: 22.sp,
      widget: const MapGpsView(),
    ),
    HomeTabInfo(
      title: localeLang.notification,
      icon: HeroIcons.bell,
      iconSize: 22.sp,
      widget: const NotificationView(),
      hasBadge: true,
    ),
  ].obs;

  Future<void> onItemTapped(int index) async {
    currentTabIndex.value = index;
    pageController.jumpToPage(index);
  }

  Future<void> onItemSwipe(int index) async {
    currentTabIndex.value = index;
    await pageController.animateToPage(
      index,
      duration: $r.times.pageTransition,
      curve: Curves.easeInOut,
    );
  }

  Future<bool> onBackCalled(BuildContext context) async {
    final now = DateTime.now();
    if (lastBackPressedTime == null ||
        now.difference(lastBackPressedTime!) > $r.times.twoSeconds) {
      lastBackPressedTime = now;
      await AppUtils.showSnackBar(
        message: localeLang.doubleTabToExit,
        type: SnackBarType.info,
      );
      return false;
    } else {
      await SystemNavigator.pop(animated: true);
      return true;
    }
  }

  //* Methods
  bool checkSettingView(int index) {
    return (isSettings.value = tabs[index].title == localeLang.me).obs.value;
  }

  Future<void> getInAppSystem() async {
    pageController = PageController();
  }

  Future<void> onNavigateChat() async {
    await Get.toNamed(Routes.CHAT);
  }
}

class HomeTabInfo {
  final dynamic icon;
  final double? iconSize;
  final String title;
  final Widget widget;
  final bool hasBadge;

  HomeTabInfo({
    required this.icon,
    required this.title,
    required this.widget,
    this.iconSize,
    this.hasBadge = false,
  });
}
