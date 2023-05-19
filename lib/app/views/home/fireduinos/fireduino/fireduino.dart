import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/home.dart';
import '../../../../network/request.dart';
import '../../../../utils/dialog.dart';
import '../../../../controllers/fireduinos.dart';
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

    final homeController = Get.find<HomeController>();
    homeController.fireduinoName.value = Get.parameters["name"]!;

    return WillPopScope(
      onWillPop: () async {
        Get.find<FireduinosController>().fetchFireduinos();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(homeController.fireduinoName.value)),
          actions: [
            IconButton(
              onPressed: () {
                showEditNameDialog(
                  deviceId: int.parse(Get.parameters["id"]!),
                  estbID: Global.user.eid!,
                  mac: Get.parameters["mac"]!,
                );
              },
              tooltip: "Edit name",
              icon: const Icon(Icons.mode_edit_outline_outlined)
            )
          ],
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
                    Obx(() => Text(homeController.fireduinoName.value, style: Theme.of(context).textTheme.titleMedium)),
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
      ),
    );
  }

  void showEditNameDialog({ String name = "", int estbID = -1, int deviceId = -1, String mac = "" }) {
    final nameController = TextEditingController(text: name.isNotEmpty ? name : Get.parameters["name"]!);
    final homeController = Get.find<HomeController>();

    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text("Edit name"),
        content: Obx(() => TextField(
          controller: nameController,
          decoration: InputDecoration(
            errorText: homeController.fireduinoEditNameMessage.value.isNotEmpty ? 
              homeController.fireduinoEditNameMessage.value :
              null
          ),
        )),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel")
          ),
          TextButton(
            onPressed: () async {
              // Clear error message
              homeController.fireduinoEditNameMessage.value = "";

              // If name is empty
              if (nameController.text.trim().isEmpty) {
                homeController.fireduinoEditNameMessage.value = "Name cannot be empty";
                return;
              }

              Get.back();
              // Show loader
              showLoader("Saving name...");
              // Edit fireduino name
              bool success = await FireduinoAPI.editFireduino(estbID, deviceId, mac, nameController.text.trim());
              // Close loader
              Get.back();

              // If success
              if (success) {
                // update the name
                Get.find<HomeController>().fireduinoName.value = nameController.text;
              }

              // Show dialog
              await showAppDialog(success ? "Success" : "Error", FireduinoAPI.message);

              // If not success, return
              if (success) return;

              // Otherwise, show edit name dialog again
              showEditNameDialog(
                name: nameController.text,
                estbID: estbID,
                deviceId: deviceId,
                mac: mac
              );
            },
            child: const Text("Save")
          )
        ],
      )
    ).then((value) {
      if (value == null) return;
      Get.parameters["name"] = value;
    });
  }
}