import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import 'package:clima/utilities/constants.dart';

class Location {
  late double latitude;
  late double longitude;

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      if (kDebugMode) {
        print(kLocationServicesDisabledMessage);
      }
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        if (kDebugMode) {
          print(kPermissionDeniedMessage);
        }
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      if (kDebugMode) {
        print(kPermissionDeniedForeverMessage);
      }
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    if (kDebugMode) {
      print(kPermissionGrantedMessage);
    }
    return true;
  }

  Future<void> getCurrentLocation() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      return;
    }
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition();
          //desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (kDebugMode) {
      print(position);
    }
  }

  @override
  String toString() {
    return 'Latitude: $latitude, Longitude: $longitude';
  }
}
