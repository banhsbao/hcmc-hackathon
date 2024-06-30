import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:heroicons/heroicons.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/widgets/base/base_silver_view.dart';

import '../controllers/homepage_controller.dart';

class HomepageView extends BaseSilverView<HomepageController> {
  const HomepageView({super.key});

  @override
  Widget body(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        controller.onBackCalled(context);
      },
      child: Obx(
        () => Scaffold(
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            itemCount: controller.tabs.length,
            activeIndex: controller.currentTabIndex.value,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.sharpEdge,
            onTap: (index) => controller.onItemTapped(index),
            splashColor: Theme.of(context).colorScheme.primary,
            splashRadius: 0,
            scaleFactor: 0,
            elevation: 16,
            height: 60,
            borderColor: $r.theme.transparent,
            backgroundColor: $r.theme.white,
            tabBuilder: (index, isActive) => Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Badge(
                    smallSize: 8,
                    backgroundColor: $r.theme.success,
                    isLabelVisible: controller.tabs[index].hasBadge &&
                        controller.hasNotification.value,
                    offset: const Offset(0, -4),
                    child: HeroIcon(
                      controller.tabs[index].icon,
                      style: isActive
                          ? HeroIconStyle.solid
                          : HeroIconStyle.outline,
                      size: controller.tabs[index].iconSize,
                      color: isActive
                          ? Theme.of(context).colorScheme.primary
                          : $r.theme.grey2,
                    ),
                  ),
                ),
                const Gap(4),
                AnimatedDefaultTextStyle(
                  curve: Curves.easeOut,
                  duration: $r.times.oneSeconds,
                  style: $r.styles.pRegular.copyWith(
                    fontSize: 11.sp,
                    color: isActive
                        ? Theme.of(context).colorScheme.primary
                        : $r.theme.grey2,
                  ),
                  child: Text(controller.tabs[index].title),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () async => controller.onCenterMap(),
            tooltip: localeLang.currentLocation,
            child: Icon(
              FluentIcons.my_location_20_regular,
              size: 24.sp,
            ),
          ),
          body: PageView(
            controller: controller.pageController,
            onPageChanged: (value) => controller.onItemSwipe(value),
            physics: const AlwaysScrollableScrollPhysics(),
            children: controller.tabs.map((e) => e.widget).toList(),
          ),
        ),
      ),
    );
  }
}
