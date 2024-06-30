import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:angelhack_hcm/app/modules/home/notification/components/notification_item.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/skeleton_shimmer.dart';

import '../controllers/notification_controller.dart';

class NotificationLoader extends GetView<NotificationController> {
  final bool isFirstPage;

  const NotificationLoader({this.isFirstPage = true, super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      child: isFirstPage
          ? ListView.separated(
              shrinkWrap: true,
              itemCount: controller.pagingController.itemList?.length ?? 10,
              separatorBuilder: (_, __) => const Gap(16),
              itemBuilder: (_, index) => NotificationItem(key: ValueKey(index)),
            )
          : const NotificationItem(),
    );
  }
}
