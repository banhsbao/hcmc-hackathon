import 'dart:async';
import 'dart:convert';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/modules/home/map_gps/components/map_gps_component.dart';
import 'package:angelhack_hcm/app/shared/constants/enums/tds_status.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/tap_splash.dart';
import 'package:flutter/material.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import 'package:angelhack_hcm/app/data/models/node.response.dart';
import 'package:angelhack_hcm/app/data/repositories/node.repo.dart';
import 'package:angelhack_hcm/app/routes/app_pages.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';
import 'package:angelhack_hcm/app/shared/widgets/base/base_controller.dart';
import 'package:angelhack_hcm/app/shared/widgets/utils/custom_dialog.dart';

class MapGpsController extends BaseController with GetTickerProviderStateMixin {
  //* Dependencies
  final nodeRepo = Get.find<NodeRepository>();

  //* Variables
  Timer? timer;
  final List<dynamic>? listData = [];
  final markers = <AnimatedMarker>[].obs;

  late AnimatedMapController? animatedMapController;
  RxBool showDetail = true.obs;
  List<NodeResponse> nodes = [];

  late final dynamic args = Get.arguments;
  LatLng currentLocation = const LatLng(0, 0);
  final int lastMovedToMarkerIndex = -1;

  //* Life Cycle
  @override
  void onInit() {
    super.onInit();
    onInitData();
    onShowNode();
  }

  @override
  void onClose() {
    markers.clear();
    animatedMapController?.dispose();
    timer?.cancel();
    super.onClose();
  }

  void startNodeUpdates() {
    timer?.cancel();
    onShowNode();
    timer = Timer.periodic($r.times.fast, (t) => onShowNode());
  }

  //* Methods
  Future<void> onInitData() async {
    animatedMapController = AnimatedMapController(vsync: this);
    currentLocation = args['currentLocation'];
  }

  Future<void> centerMapOnCurrentLocation() async {
    final currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    animatedMapController?.mapController
        .move(LatLng(currentPosition.latitude, currentPosition.longitude), 16);
  }

  Future<void> onLogout() async {
    await Get.dialog(
      CustomDialog(
        title: localeLang.logout,
        subtitle: localeLang.beforeLogout,
        buttonText: localeLang.logout,
        buttonColor: Theme.of(gContext).colorScheme.error,
        isButtonBold: true,
        onTap: () async {
          final result = await Amplify.Auth.signOut();
          if (result is CognitoCompleteSignOut) {
            await Get.offAllNamed(Routes.SPLASH);
          } else if (result is CognitoFailedSignOut) {
            safePrint('Error signing user out: ${result.exception.message}');
          }
        },
      ),
    );
  }

  Future<void> showNodeDetails(NodeResponse node) async {
    showDetail.value = !showDetail.value;

    await Get.bottomSheet(
      MapGPSItem(
        node: node,
      ),
    );
  }

  Future<void> onShowNode() async {
    final data = await nodeRepo.getNodes();
    final List<dynamic> listData = jsonDecode(data);

    nodes = listData.map((nodeMap) => NodeResponse.fromJson(nodeMap)).toList();

    if (nodes.any((node) => node.latitude != null && node.longitude != null)) {
      final validNodes = nodes
          .where(
            (node) =>
                node.latitude != null &&
                node.longitude != null &&
                node.status != null,
          )
          .toList();

      if (validNodes.isNotEmpty) {
        for (final node in nodes) {
          final marker = AnimatedMarker(
            point: LatLng(
              double.parse(node.latitude ?? '0'),
              double.parse(node.longitude ?? '0'),
            ),
            builder: (context, animation) {
              return TapSplash(
                onTap: () => showNodeDetails(
                  nodes.firstWhere((element) => element.nodeId == node.nodeId),
                ),
                child: Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: TDSStatusHelper.getColorPH(
                      double.tryParse(node.ph ?? ''),
                    ),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Icon(
                    TDSStatusHelper.getIcon(
                      TDSStatusHelper.getName(node.status ?? 'unknown'),
                    ),
                    color: Theme.of(gContext).colorScheme.onPrimary,
                    size: 18,
                  ),
                ),
              );
            },
          );

          markers.add(marker);
        }
      } else {
        safePrint('No valid nodes found');
      }
    }
  }
}
