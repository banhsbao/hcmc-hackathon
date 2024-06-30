import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:angelhack_hcm/app/shared/constants/resources/assets.gen.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';
import 'package:angelhack_hcm/app/shared/widgets/base/base_silver_view.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/custom_appbar.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/keyboard_dismisser.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/svg_asset.dart';

import '../components/map_gps_component.dart';
import '../controllers/map_gps_controller.dart';

class MapGpsView extends BaseSilverView<MapGpsController> {
  const MapGpsView({super.key});

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: KeyboardDismisser(
          child: Stack(
            children: [
              //* Background
              Container(
                width: width.w,
                height: height / 8,
                color: Theme.of(context).colorScheme.primary,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        SvgAsset(
                          height: height,
                          width: constraints.maxWidth,
                          Assets.svgs.vectorCurved1.path,
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: SvgAsset(
                            height: constraints.maxHeight + 10,
                            width: constraints.maxWidth,
                            Assets.svgs.backgroundPattern.path,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              //* Appbar
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: CustomAppBar(
                  title: localeLang.map,
                  actions: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => controller.onLogout(),
                      child: Icon(
                        FluentIcons.sign_out_20_regular,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),

              //* Body
              Column(
                children: [
                  Container(
                    height: height / 8,
                  ),

                  //* Chat List
                  Expanded(
                    child: FlutterMap(
                      mapController:
                          controller.animatedMapController?.mapController,
                      options: MapOptions(
                        initialCenter: controller.currentLocation,
                        initialZoom: 16,
                        minZoom: 0,
                        maxZoom: 19,
                        keepAlive: true,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.hcm.angelhack',
                          tileProvider: CancellableNetworkTileProvider(),
                          maxZoom: 18,
                        ),
                        CurrentLocationLayer(
                          style: LocationMarkerStyle(
                            marker: DefaultLocationMarker(
                              child: Icon(
                                FluentIcons.person_20_filled,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 18.sp,
                              ),
                            ),
                            markerSize: const Size(32, 32),
                            showHeadingSector: false,
                            accuracyCircleColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                          ),
                        ),
                        AnimatedMarkerLayer(
                          markers: controller.markers,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        separator: const Gap(8),
        children: [
          FloatingActionButton(
            onPressed: () async => controller.animatedMapController?.animateTo(
              dest: controller.currentLocation,
              rotation: 0,
              zoom: 16,
            ),
            tooltip: localeLang.currentLocation,
            child: Icon(
              FluentIcons.my_location_20_regular,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
