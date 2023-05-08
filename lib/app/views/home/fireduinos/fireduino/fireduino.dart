import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../env/config.dart';
import '../../../../store/global.dart';
import '../../../../widgets/status.dart';

class FireduinoPage extends StatelessWidget {
  const FireduinoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RxString status = "Waiting for user...".obs;
    final RxString mainStatus = "Extinguish".obs;

    return Scaffold(
      appBar: AppBar(
        title: Text(Get.parameters["name"]!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Name: ", style: TextStyle(letterSpacing: 0, fontSize: 16)),
                  Text(Get.parameters["name"]!, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("MAC Address: ", style: TextStyle(letterSpacing: 0, fontSize: 16)),
                  Text(Get.parameters["mac"]!, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Status: ", style: TextStyle(letterSpacing: 0, fontSize: 16)),
                  Obx(() => Text(status.value, style: Theme.of(context).textTheme.titleMedium)),
                ],
              ),
              const SizedBox(height: 64),
              Obx(() => FireduinoStatus(isOnline: Global.onlineFireduinos.indexWhere((el) => el["uid"] == Get.parameters['mac']) >= 0)),
              const SizedBox(height: 64),
              GestureDetector(
                onTapDown: (TapDownDetails details) {
                  print("DOWN");
                  mainStatus.value = "Extinguishing...";
                  status.value = "Extinguishing...";
                },
                onTapUp: (TapUpDetails details) {
                  print("UP");
                  mainStatus.value = "Extinguish";
                  status.value = "Extinguished";
                },
                onTapCancel: () {
                  print("CANCEL");
                  mainStatus.value = "Extinguish";
                  status.value = "Cancelled";
                },
                child: Container(
                  width: 275,
                  height: 275,
                  decoration: BoxDecoration(
                    color: Get.theme.brightness == Brightness.light ?
                      Get.theme.colorScheme.primary :
                      Get.theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(150),
                    boxShadow: [
                      BoxShadow(
                        color: Get.theme.brightness == Brightness.light ?
                          Get.theme.colorScheme.primary.withOpacity(0.5) :
                          Get.theme.colorScheme.primaryContainer.withOpacity(0.5),
                        blurRadius: 16,
                        offset: const Offset(0, 8)
                      )
                    ]
                  ),
                  child: Center(
                    child: Obx(() => Text(mainStatus.value, style: Get.textTheme.headlineMedium!.copyWith(
                      fontFamily: appDefaultFont,
                      color: Get.theme.brightness == Brightness.light ?
                        Get.theme.colorScheme.onPrimary :
                        Get.theme.colorScheme.onPrimaryContainer
                    )))
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}