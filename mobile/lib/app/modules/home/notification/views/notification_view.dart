import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/modules/home/notification/components/notification_item.dart';
import 'package:angelhack_hcm/app/modules/home/notification/components/notification_loader.dart';
import 'package:angelhack_hcm/app/shared/constants/resources/assets.gen.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';
import 'package:angelhack_hcm/app/shared/widgets/empty/empty_notifications.dart';
import 'package:angelhack_hcm/app/shared/widgets/error/error_notifications.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/custom_appbar.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/svg_asset.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            //* Background Curved
            SizedBox(
              width: width,
              height: height / 5.5,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      SvgAsset(
                        height: height,
                        width: constraints.maxWidth,
                        Assets.svgs.vectorCurved1.path,
                      ),
                      SvgAsset(
                        height: height + 10,
                        width: constraints.maxWidth,
                        Assets.svgs.vectorCurved3.path,
                      ),
                    ],
                  );
                },
              ),
            ),

            //* Appbar
            Obx(
              () => Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: CustomAppBar(
                  showTitleCenter: true,
                  title: localeLang.notification,
                  backgroundColor: $r.theme.transparent,
                  actions: [
                    if (controller.hasReadAllNotification &&
                        controller.hasNotification)
                      CupertinoButton(
                        padding: const EdgeInsets.only(right: 16),
                        child: Icon(
                          FluentIcons.text_grammar_checkmark_20_regular,
                          color: $r.theme.white,
                        ),
                        onPressed: () => {},
                      ),
                  ],
                ),
              ),
            ),

            //* Body
            Column(
              children: [
                const Spacer(),
                Expanded(
                  flex: 7,
                  child: Container(
                    width: width,
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: RefreshIndicator(
                      onRefresh: () => controller.onRefresh(),
                      child: SizedBox(
                        height: height,
                        child: PagedListView.separated(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          pagingController: controller.pagingController,
                          separatorBuilder: (context, index) => const Gap(16),
                          builderDelegate: PagedChildBuilderDelegate(
                            animateTransitions: true,
                            transitionDuration: $r.times.fast,

                            //* Progress
                            firstPageProgressIndicatorBuilder: (_) =>
                                const NotificationLoader(),
                            newPageProgressIndicatorBuilder: (_) =>
                                const NotificationLoader(
                              isFirstPage: false,
                            ),

                            //* Error
                            noItemsFoundIndicatorBuilder: (_) =>
                                const EmptyNotifications(),
                            firstPageErrorIndicatorBuilder: (_) =>
                                ErrorNotifications(
                              onRetry: () => controller.onRefresh(),
                            ),

                            //* Item
                            itemBuilder: (_, item, index) => NotificationItem(
                              key: ValueKey(index),
                              pgCtrl: controller.pagingController,
                              index: int.tryParse(
                                controller.pagingController.itemList
                                    ?.elementAt(index)
                                    .notifyId
                                    .s,
                              ),
                              title: controller.pagingController.itemList
                                  ?.elementAt(index)
                                  .title
                                  .s,
                              content: controller.pagingController.itemList
                                  ?.elementAt(index)
                                  .body
                                  .s,
                              timeDifferent: controller
                                  .pagingController.itemList
                                  ?.elementAt(index)
                                  .timestamp
                                  .s,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
