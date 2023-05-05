import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main.dart';
import '../env/config.dart';
import '../store/global.dart';
import '../utils/dialog.dart';

class FireduinoDrawer extends StatelessWidget {
  const FireduinoDrawer({ required this.onSelect, super.key});

  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();

    return Drawer(
      child: SafeArea(
        child: Obx(() => NavigationDrawer(
          selectedIndex: mainController.pageIndex.value,
          onDestinationSelected: (int index) {
            Get.back();

            // If logout
            if (index == 8) {
              confirmLogout();
              return;
            }

            onSelect(index);
          },
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(appName, style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontFamily: appDefaultFont,
                  )),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Image.asset('assets/png/fireduino_icon.png', width: 32),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ 
                          Text(Global.user.getFullname(), style: Theme.of(context).textTheme.titleMedium),
                          Text(Global.user.getEmail(), style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontFamily: "Roboto"
                          ))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                ], 
              ),
            ),
            
            ...Global.drawerItems.map((e) => NavigationDrawerDestination(
              icon: Icon(e['icon']),
              label: Text(e['title'], style: const TextStyle(fontFamily: appDefaultFont)),
              selectedIcon: Icon(e['sicon']),
            )).toList(),
            
            const Padding(
              padding:EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
              child: Divider(height: 1)
            ),

            const NavigationDrawerDestination(
              label:Text("Preferences"),
              icon: Icon(Icons.settings_suggest_outlined),
              selectedIcon:Icon(Icons.settings_suggest_rounded),
            ),

            const NavigationDrawerDestination(
              label:Text("Logout"),
              icon: Icon(Icons.logout_outlined),
              selectedIcon:Icon(Icons.logout_rounded),
            ),
          ]
        ),
      ))
    );
  }

  void confirmLogout() {
    showAppDialog("Logout", "Are you sure you want to logout?",
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Get.back();
          }
        ),
        TextButton(
          child: const Text("Logout"),
          onPressed: () {
            Get.back();
            Get.find<MainController>().logout();
          }
        )
      ]
    );
  }
}