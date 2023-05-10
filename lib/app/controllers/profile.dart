import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
}