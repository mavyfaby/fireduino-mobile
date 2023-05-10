import 'package:fireduino/app/network/socket.dart';
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
    final fireduinoCtrl = Get.find<FireduinosController>();

    return  FutureBuilder(
      future: fireduinoCtrl.fetchFireduinos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If has error
          if (snapshot.hasError) {
            return const Center(child: Text("An error has occured!"));
          }
          // If successful
          return RefreshIndicator(
            onRefresh: () async {
              // Fetch fireduinos
              await fireduinoCtrl.fetchFireduinos();
              // Get online fireduinos
              FireduinoSocket.instance.getOnlineFireduinos();
            },
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() => fireduinoCtrl.count > 0 ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: 0.75,
                    child: Text("Fireduinos: ${fireduinoCtrl.count}",
                      style: Theme.of(context).textTheme.titleSmall
                    )
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: AlignedGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      itemCount: fireduinoCtrl.count,
                      itemBuilder: (context, index) {
                        return Obx(() => FireduinoTile(
                          name: fireduinoCtrl.devices[index].name,
                          mac: fireduinoCtrl.devices[index].mac,
                          isOnline: Global.onlineFireduinos.indexWhere((el) => el["mac"] == fireduinoCtrl.devices[index].mac) >= 0,
                          index: index + 1,
                        ));
                      },
                    ),
                  )
                ],
              ) : Center(
                child: Text("No fireduinos found", style: Theme.of(context).textTheme.titleSmall)
              ))
            )
          );
        }
        
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}