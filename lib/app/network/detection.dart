import 'dart:async';

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home.dart';
import '../controllers/main.dart';
import '../utils/dialog.dart';

/// Calls the [onFireDetect] if a fire is detected
void onFireDetect(String mac) {
  debugPrint("FIRE DETECTED: $mac");
  // Vibrate the device
  Vibration.vibrate(pattern: getPatterns(15));
  FlutterRingtonePlayer.play(
    fromAsset: "assets/alarm/fire_alarm.mp3",
    looping: true,
    asAlarm: true,
  );

  showAppDialog("Fire Detected!", "The fireduino $mac detected a fire in your area and is already responding and extinguishing the fire!", actions: [
    TextButton(
      child: const Text("Go to Fireduinos"),
      onPressed: () {
        FlutterRingtonePlayer.stop();
        Vibration.cancel();
        Get.back();
        Get.find<MainController>().pageIndex.value = 1;
        Get.find<HomeController>().pageIndex.value = 1;

        Timer(const Duration(milliseconds: 100), () {
          Get.find<HomeController>().pageController.animateToPage(1,
            duration: const Duration(milliseconds: 210),
            curve: Curves.easeInOut
          );
        });
      },
    ),
  ]);
}

/// Calls the [onSmokeDetect] if a smoke is detected
void onSmokeDetect(String mac) {
  debugPrint("SMOKE DETECTED: $mac");

  // Vibrate the device
  Vibration.vibrate(pattern: getPatterns(5));
  FlutterRingtonePlayer.play(
    fromAsset: "assets/alarm/smoke_alarm.mp3",
    looping: true,
    asAlarm: true,
  );

  showAppDialog("Smoke Detected!", "The fireduino $mac detected a smoke in your area. Please check your surroundings!", actions: [
    TextButton(
      child: const Text("Go to Fireduinos"),
      onPressed: () {
        FlutterRingtonePlayer.stop();
        Vibration.cancel();
        Get.back();
        Get.find<MainController>().pageIndex.value = 1;
        Get.find<HomeController>().pageIndex.value = 1;

        Timer(const Duration(milliseconds: 100), () {
          Get.find<HomeController>().pageController.animateToPage(1,
            duration: const Duration(milliseconds: 210),
            curve: Curves.easeInOut
          );
        });
      },
    ),
  ]);
}

List<int> getPatterns(int count) {
  final List<int> patterns = [];

  for (var i = 0; i < count; i++) {
    patterns.add(500);
    patterns.add(1000);
  }

  return patterns;
}