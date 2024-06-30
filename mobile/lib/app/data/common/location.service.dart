import 'package:angelhack_hcm/app/data/di.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<LatLng> getPosition() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      final status = await Permission.location.status;
      if (status.isGranted) {
        final lastPosition = await Geolocator.getLastKnownPosition();
        if (lastPosition != null) {
          return LatLng(lastPosition.latitude, lastPosition.longitude);
        }

        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: $r.times.fetchPeriod,
        );
        return LatLng(position.latitude, position.longitude);
      } else if (status.isDenied) {
        await [Permission.location].request();
      }
    } else {
      // Permission is disabled
    }

    if (await Permission.location.isPermanentlyDenied) {
      await openAppSettings();
    }

    return const LatLng(0, 0);
  }
}
