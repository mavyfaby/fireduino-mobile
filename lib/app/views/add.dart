import 'package:fireduino/app/network/request.dart';
import 'package:fireduino/app/store/global.dart';
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
    final TextEditingController name = TextEditingController();
    final RxString nameErrorText = "".obs;
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
              controller: name,
              decoration: CustomInputDecoration(
                context: context,
                labelText: "Name",
                prefixIcon: const Icon(Icons.fireplace_outlined),
                errorText: nameErrorText.value.isEmpty ? null : nameErrorText.value,
              ),
            )),
            Obx(() => SizedBox(
              height: nameErrorText.value.isEmpty ? 0 : 16,
            )),
            Obx(() => TextField(
              controller: serialId,
              decoration: CustomInputDecoration(
                context: context,
                labelText: "Serial ID",
                prefixIcon: const Icon(Icons.key),
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
                    nameErrorText.value = "";
                    // Check the serial id
                    checkSerial(serialId.text, true, (isAvailable) async {
                      // Check if the server is available
                      if (isAvailable == null) {
                        return;
                      }

                      // If name is empty
                      if (name.text.isEmpty) {
                        // Set the error text
                        nameErrorText.value = "Oops! The name you entered is empty.";
                        return;
                      }
                      
                      // Check if the device is available
                      if (isAvailable) {
                        // Show the loading dialog
                        showLoader("Adding fireduino device...");

                        // Add the fireduino device
                        if (await FireduinoAPI.addFireduino(Global.user.eid!, serialId.text, name.text)) {
                          // Hide the loading dialog
                          Get.back();
                          // If success, show dialog
                          await showAppDialog("Success", "Fireduino device ${name.text} added successfully to your establishment!");
                          // Pop the page
                          Get.back();
                          return;
                        }

                        // Hide the loading dialog
                        Get.back();
                        // Show the error dialog
                        showAppDialog("Error", FireduinoAPI.message);
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
    FireduinoSocket.instance.checkFireduino(serialId, (isAvailable) async {
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
        await showAppDialog("Success", "The Serial ID you entered is available.");
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
