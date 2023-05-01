import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../network/socket.dart';
import '../utils/dialog.dart';
import '../custom/decoration.dart';

class AddFireduinoPage extends StatelessWidget {
  const AddFireduinoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController serialId = TextEditingController();
    final RxString errorText = "".obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Fireduino"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Note: Make sure the fireduino device is connected to the server."),
            const SizedBox(height: 16),
            Obx(() => TextField(
              controller: serialId,
              decoration: CustomInputDecoration(
                context: context,
                labelText: "Fireduino Serial ID",
                prefixIcon: const Icon(Icons.fireplace_outlined),
                errorText: errorText.value.isEmpty ? null : errorText.value,
              ),
            )),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton.tonal(
                  onPressed: () {
                    // Reset the error text
                    errorText.value = "";
                    // Check the serial id
                    checkSerial(serialId.text, false, (isAvailable) {
                      if (isAvailable == null || isAvailable) {
                        return;
                      }

                      // Set the error text
                      errorText.value = "Oops! The Serial ID you entered is invalid or doesn't exist.";
                    });
                  },
                  child: const Text("Check device")
                ),
                const SizedBox(width: 16),
                FilledButton(
                  onPressed: () {
                    // Reset the error text
                    errorText.value = "";
                    // Check the serial id
                    checkSerial(serialId.text, true, (isAvailable) {
                      if (isAvailable == null) {
                        return;
                      }

                      if (isAvailable) {
                        // TODO: Add the device
                        return;
                      }

                      // Set the error text
                      errorText.value = "Oops! The Serial ID you entered is invalid or doesn't exist.";
                    });
                  },
                  child: const Text("Add device")
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  /// Check the serial id
  void checkSerial(String serialId, bool isAdd, Function callback) {
    // Show the loading dialog
    showLoader("Checking fireduino...");
    // Check the fireduino device
    FireduinoSocket.instance.checkFireduino(serialId, (isAvailable) {
      // Hide the loading dialog
      Get.back();

      // Check if the server is available
      if (isAvailable == null) {
        // Show the error dialog
        showAppDialog("Error", "Server not available.");
        callback(null);
      }

      // Check if the device is available and is not from the add button
      if (isAvailable && !isAdd) {
        // Show the snackbar
        showAppDialog("Success", "The Serial ID you entered is available.");
      }

      // Check if the device is connected
      if (isAvailable) {
        callback(true);
        return;
      }

      callback(false);
    });
  }
}
