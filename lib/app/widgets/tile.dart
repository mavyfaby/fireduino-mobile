import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../store/global.dart';

class FireduinoTile extends StatelessWidget {
  const FireduinoTile({
    required this.index,
    required this.name,
    required this.serialId,
    super.key
  });

  final int index;
  final String name;
  final String serialId;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Get.theme.brightness == Brightness.light ?
        Get.theme.colorScheme.primaryContainer :
        Get.theme.colorScheme.surfaceVariant,
      child: InkWell(
        onTap: () {
          Get.toNamed("/fireduino", parameters: {
            "name": name,
            "serialId": serialId
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text("#$index", style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant
              )),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant
                  )),
                  const SizedBox(height: 4),
                  Text(serialId.toString(), style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() => Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Global.onlineFireduinos.indexWhere((el) => el["uid"] == Get.parameters['serialId']) >= 0 ?
                          Get.theme.brightness == Brightness.light ?
                            Colors.teal.shade600 :
                            Colors.teal.shade300 :
                          Get.theme.brightness == Brightness.light ?
                            Colors.red.shade600 :
                            Colors.red.shade300,
                      ),
                    ))
                  ],
                )
              )
            ],
          ),
        ),
      )
    );
  }
}