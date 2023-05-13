import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../env/config.dart';
import '../../../../store/global.dart';
import '../../../../widgets/status.dart';

class FireduinoPage extends StatelessWidget {
  const FireduinoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isExtinguishing = false.obs;
    final mainStatus = Global.onlineFireduinos.indexWhere((el) => el["mac"] == Get.parameters['mac']) >= 0 ?
      'Extinguish'.obs :
      "Offline".obs;

    Global.onlineFireduinos.listen((p0) { 
      if (p0.indexWhere((el) => el["mac"] == Get.parameters['mac']) < 0) {
        mainStatus.value = "Offline";
        isExtinguishing.value = false;
        return;
      } 

      mainStatus.value = "Extinguish";
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(Get.parameters["name"]!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                  const Text("Status: ", style: TextStyle(letterSpacing: 0, fontSize: 16)),
                  Obx(() => Text(Global.onlineFireduinos.indexWhere((el) => el["mac"] == Get.parameters['mac']) >= 0 ? 'Online' : 'Offline', style: Theme.of(context).textTheme.titleMedium)),
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
              const SizedBox(height: 64),
              Obx(() => FireduinoStatus(isOnline: Global.onlineFireduinos.indexWhere((el) => el["mac"] == Get.parameters['mac']) >= 0)),
              const SizedBox(height: 64),
              SizedBox(
                width: 275,
                height: 275,
                child: Obx(() => FilledButton(
                  onPressed: Global.onlineFireduinos.indexWhere((el) => el["mac"] == Get.parameters['mac']) >= 0 ? () {
                    if (isExtinguishing.value) {
                      mainStatus.value = "Extinguish";
                      isExtinguishing.value = false;
                      return;
                    }
    
                    mainStatus.value = "Extinguishing...";
                    isExtinguishing.value = true;
                  } : null,
                  child: Text(mainStatus.value, style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontFamily: appDefaultFont,
                    color: Global.onlineFireduinos.indexWhere((el) => el["mac"] == Get.parameters['mac']) >= 0 ?
                      Theme.of(context).colorScheme.onPrimary :
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                  ))
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}