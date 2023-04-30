import 'package:fireduino/app/network/socket.dart';
import 'package:fireduino/app/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../custom/decoration.dart';

class AddFireduinoPage extends StatelessWidget {
  const AddFireduinoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController serialId = TextEditingController();

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
            TextField(
              controller: serialId,
              decoration: CustomInputDecoration(
                context: context,
                labelText: "Fireduino Serial ID",
                prefixIcon: const Icon(Icons.fireplace_outlined)
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton.tonal(
                  onPressed: () {
                    // Show the loading dialog
                    showLoader("Checking fireduino...");
                    // Check the fireduino device
                    FireduinoSocket.instance.checkFireduino(serialId.text, (isAvailable) {
                      // Hide the loading dialog
                      Get.back();

                      if (isAvailable == null) {
                        // Show the error dialog
                        showAppDialog("Error", "Server not available.");
                        return;
                      }

                      // Check if the device is connected
                      if (isAvailable) {
                        // Show the success dialog
                        showAppDialog("Success", "Fireduino is connected to the server.");
                      } else {
                        // Show the error dialog
                        showAppDialog("Error", "Fireduino is not connected to the server.");
                      }
                    });
                  },
                  child: const Text("Check device")
                ),
                const SizedBox(width: 16),
                FilledButton(
                  onPressed: () {

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
}