import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home.dart';
import '../utils/validation.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scanController = MobileScannerController();
    final isFlashEnabled = false.obs;

    bool isPopped = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR"),
      ),

      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.qr_code_scanner_rounded, size: 56),
              const SizedBox(height: 8),
              Text("Scan QR Code", style: Get.textTheme.headlineSmall),
              const SizedBox(height: 8),
              const Text("Scan the QR code on the Fireduino device."),
              const SizedBox(height: 32),
        
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: AiBarcodeScanner(
                    canPop: false,
                    controller: scanController,
                    placeholderBuilder: (p0, p1) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    validator: (value) {
                      return isMacAddress(value);
                    },
                    borderColor: Get.theme.brightness == Brightness.dark ?
                      Get.theme.colorScheme.primary :
                      Get.theme.colorScheme.primaryContainer,
                    hintWidget: const SizedBox(),
                    onScan: (String value) {
                      // If the page is popped, do nothing
                      if (isPopped) return;
                      // Set the page as popped
                      isPopped = true;
                      // Update the MAC Address in the Home Controller
                      Get.find<HomeController>().mac.text = value;
                      // Pop the page
                      Get.back();
                    }
                  ),
                ),
              ),

              const SizedBox(height: 32),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => Switch(
                    value: isFlashEnabled.value,
                    thumbIcon:  MaterialStateProperty.resolveWith<Icon?>((Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return const Icon(Icons.flash_on);
                      }
                
                      return const Icon(Icons.flash_off);
                    }),
                    onChanged: (v) {
                      isFlashEnabled.value = v;
                      scanController.toggleTorch();
                    }
                  )),
                  const SizedBox(width: 8),
                  const Text("Turn On Flashlight"),
                ],
              ),        
              const SizedBox(height: 32),
            ],
          ),
        ),
      )
    );
  }
}
