import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/dialog.dart';

class FireduinoLocation {
  static ensureLocationPermissionAccepted() async {
    // Check if location permission is granted
    LocationPermission permission = await Geolocator.checkPermission();

    // If the permission accepted, return true
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      return true;
    }

    // Request location permission
    permission = await Geolocator.requestPermission();

    // If the permission is denied, request it again
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // If the permission is denied, request it again
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // If the permission is denied forever, request it again
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    // If the permission is granted, return true
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      return true;
    }

    // If the permission is not granted, return false
    return false;
  }

  static ensureLocationServiceEnabled() async {
    // Check if location service is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // If the service is disabled, request it to be enabled
    if (!serviceEnabled) {
      // Show dialog to enable location service
      // showAppDialog(title, message, actions: [])
      await showAppDialog(
        "Location Service Disabled",
        "Please enable location service to use this feature.",
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Get.back();
            }
          ),
          TextButton(
            child: const Text("Enable"),
            onPressed: () async {
              // Close dialog
              Get.back();
              // Open location settings
              serviceEnabled = await Geolocator.openLocationSettings();
            }
          )
        ]
      );
    }

    return serviceEnabled;
  }
}