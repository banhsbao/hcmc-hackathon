import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/loading_spinner.dart';

import 'base_controller.dart';

abstract class BaseView<Controller extends BaseController>
    extends GetView<Controller> {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return _renderView(context);
  }

  Widget _renderView(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: appBar(context),
      body: Stack(
        children: [
          Obx(
            () => controller.isLoading.value ? _renderLoading() : body(context),
          ),
          Obx(
            () => controller.isOverlayLoading.value
                ? _renderLoadingOverlay()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget? appBar(BuildContext context);
  Widget body(BuildContext context);

  Widget _renderLoading() {
    return Scaffold(
      backgroundColor: Theme.of(gContext).colorScheme.onInverseSurface,
      body: const Center(child: LoadingSpinner()),
    );
  }

  Widget _renderLoadingOverlay() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: $r.theme.black.withOpacity(0.7),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingSpinner(
              color: $r.theme.white,
            ),
            SizedBox(height: 16.h),
            Obx(
              () => Text(
                controller.loadingText.value,
                style: $r.styles.pSemiBold.copyWith(
                  fontSize: 16,
                  color: $r.theme.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
