import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/styles/app_design.dart';
import 'package:angelhack_hcm/app/shared/utils/helpers/date.dart';
import 'package:angelhack_hcm/app/shared/utils/helpers/misc.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/tap_splash.dart';

import '../controllers/notification_controller.dart';

class NotificationItem extends GetView<NotificationController> {
  final String? content;
  final String? title;
  final int? index;
  final int? timeDifferent;
  final PagingController<int, dynamic>? pgCtrl;

  const NotificationItem({
    super.key,
    this.content,
    this.index,
    this.timeDifferent,
    this.title,
    this.pgCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return TapSplash(
      radius: 12,
      onTap: () {},
      child: Container(
        height: 90.h,
        padding: const EdgeInsets.all(16),
        decoration: AppDesign.boxDecorationContainerCardShadow(
          Theme.of(context).colorScheme.onInverseSurface,
          $r.theme.shadow,
          12,
          0,
          4,
          16,
          0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Icon(
                    FluentIcons.megaphone_20_regular,
                    color: $r.theme.white,
                    size: 16,
                  ),
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isNullOrEmpty(title) ? localeLang.none : title!,
                            overflow: TextOverflow.clip,
                            style: $r.styles.pSemiBold.copyWith(
                              fontSize: 13,
                              color: $r.theme.black,
                            ),
                          ),
                          Text(
                            isNullOrEmpty(content) ? localeLang.none : content!,
                            overflow: TextOverflow.ellipsis,
                            style: $r.styles.pMedium.copyWith(
                              fontSize: 12,
                              color: $r.theme.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      isNullOrEmpty(timeDifferent)
                          ? localeLang.none
                          : getDifferentTime(timeDifferent!),
                      style: $r.styles.pRegular.copyWith(
                        fontSize: 12,
                        color: $r.theme.grey1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
