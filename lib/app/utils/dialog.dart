import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Shows a dialog with the given [title], [message], and [actions].
Future<dynamic> showAppDialog(String title, String message, { List<Widget>? actions }) async {
  /// The default actions for the dialog.
  actions ??= [
    TextButton(
      child: const Text("OK"),
      onPressed: () => Get.back(),
    ),
  ];

  return Get.dialog(WillPopScope(
    onWillPop: () async => false,
    child: AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: actions,
    ),
  ));
}

/// Shows a loader with the given [message].
void showLoader(String message, { bool dissmisibile = false }) {
  Get.dialog(
    WillPopScope(
      onWillPop: () async => dissmisibile,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(32),
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(message),
          ],
        ),
      ),
    ),
  );
}
