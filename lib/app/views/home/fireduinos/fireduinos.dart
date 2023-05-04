import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/fireduinos.dart';
import '../../../store/global.dart';
import '../../../widgets/tile.dart';

class FireduinosPage extends StatelessWidget {
  const FireduinosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: Get.find<FireduinosController>().fetchFireduinos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If has error
          if (snapshot.hasError) {
            return const Center(child: Text("An error has occured!"));
          }
          // If successful
          return RefreshIndicator(
            onRefresh: () async {
              await Get.find<FireduinosController>().fetchFireduinos();
            },
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
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
                        return Obx(() => FireduinoTile(
                          name: Get.find<FireduinosController>().devices[index].name,
                          serialId: Get.find<FireduinosController>().devices[index].serialId,
                          isOnline: Global.onlineFireduinos.indexWhere((el) => el["uid"] == Get.find<FireduinosController>().devices[index].serialId) >= 0,
                          index: index + 1,
                        ));
                      },
                    ),
                  )
                ],
              ))
            )
          );
        }
        
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}