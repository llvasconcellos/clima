import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

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

  void getLocation() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      return;
    }
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    if (kDebugMode) {
      print(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getLocation();
          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}
