import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Show a snackbar with the given [message].
void showAppSnackbar(String message, { Duration duration = const Duration(seconds: 5) }) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
    )
  );
}