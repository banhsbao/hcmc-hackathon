import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';

import '../controllers/login_controller.dart';

class LoginErrorMessage extends GetView<LoginController> {
  const LoginErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: controller.errorMessage.isNotEmpty,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: width.w,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(gContext).colorScheme.error.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: controller.errorMessage.isNotEmpty
                      ? Text(
                          '${controller.errorMessage.value}!',
                          style: $r.styles.pSemiBold.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      );
    });
  }
}
