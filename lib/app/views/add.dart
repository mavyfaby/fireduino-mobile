import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../network/request.dart';
import '../store/global.dart';
import '../network/socket.dart';
import '../utils/dialog.dart';
import '../custom/decoration.dart';

class AddFireduinoPage extends StatelessWidget {
  const AddFireduinoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController mac = TextEditingController();
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Obx(() => TextField(
                    controller: mac,
                    decoration: CustomInputDecoration(
                      context: context,
                      labelText: "MAC Address",
                      prefixIcon: const Icon(Icons.wifi_tethering_sharp),
                      errorText: errorText.value.isEmpty ? null : errorText.value,
                    ),
                  )),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextButton.icon(
                    label: const Text("Scan"),
                    icon: const Icon(Icons.qr_code_scanner_rounded),
                    onPressed: () {
                
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton.tonal(
                  onPressed: () {
                    // Reset the error text
                    errorText.value = "";
                    // Check the mac address
                    checkMacAddress(mac.text, false, (isAvailable) {
                      if (isAvailable == null || isAvailable) {
                        return;
                      }

                      // Set the error text
                      errorText.value = "Oops! MAC Address is invalid or doesn't exist.";
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
                    // Check the mac address
                    checkMacAddress(mac.text, true, (isAvailable) async {
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
                        if (await FireduinoAPI.addFireduino(Global.user.eid!, mac.text, name.text)) {
                          // Hide the loading dialog
                          Get.back();
                          // If success, show dialog
                          await showAppDialog("Add Success!", "Fireduino device ${name.text} added successfully to your establishment!");
                          // Pop the page
                          Get.back();
                          // Force update
                          Get.forceAppUpdate();
                          // Return
                          return;
                        }

                        // Hide the loading dialog
                        Get.back();
                        // Show the error dialog
                        showAppDialog("Error", FireduinoAPI.message);
                        return;
                      }

                      // Set the error text
                      errorText.value = "Oops! MAC Address is invalid or doesn't exist.";
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

  /// Check the mac address
  void checkMacAddress(String mac, bool isAdd, Function callback) {
    // Show the loading dialog
    showLoader("Checking MAC Address...");
    // Check the fireduino device
    FireduinoSocket.instance.checkFireduino(mac, (isAvailable) async {
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
        await showAppDialog("Success!", "MAC Address is available.");
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
