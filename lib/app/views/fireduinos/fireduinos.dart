import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/fireduinos.dart';
import '../../models/fireduino.dart';
import '../../network/request.dart';
import '../../utils/dialog.dart';
import './tile.dart';

class FireduinosPage extends StatelessWidget {
  const FireduinosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await fetchFireduinos();
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.75,
              child: Text("${Get.find<FireduinosController>().count} total number of Fireduinos",
                style: Theme.of(context).textTheme.titleSmall
              )
            ),
            const SizedBox(height: 16),
            Expanded(
              child: AlignedGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemCount: Get.find<FireduinosController>().count,
                itemBuilder: (context, index) {
                  return FireduinoTile(
                    name: Get.find<FireduinosController>().devices[index].name,
                    serialId: Get.find<FireduinosController>().devices[index].serialId,
                    index: index + 1,
                  );
                },
              ),
            )
          ],
        ))
      )
    );
  }

  Future<void> fetchFireduinos() async {
    List<FireduinoModel>? devices = await FireduinoAPI.fetchFireduinos();

    if (devices == null) {
      showAppDialog("Error", FireduinoAPI.message);
      return;
    }

    print("Fireduinos fetched successfully");
    Get.find<FireduinosController>().devices.value = devices;
  }
}