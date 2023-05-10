import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../store/store.dart';
import '../controllers/profile.dart';
import '../env/config.dart';
import '../store/global.dart';
import '../utils/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the profile controller
    final profileController = Get.find<ProfileController>();
    // Set the initial value of the dark mode switch
    profileController.themeMode.value = Global.themeMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Icon(
                  Icons.account_circle,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 125,
                ),
                const SizedBox(height: 8),
                Text("${Global.user.firstName} ${Global.user.lastName}" , style: Get.textTheme.headlineSmall!.copyWith(
                  fontFamily: appDefaultFont
                )),
                const SizedBox(height: 16),
                Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.dark_mode_outlined),
                      title: const Text('Dark Mode'),
                      subtitle: Obx(() => Text(getThemeModeName(profileController.themeMode.value))),
                      trailing: MenuAnchor(
                        builder: (context, controller, child) {
                          return FilledButton.tonal(
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            child: const Text("Change")
                          );
                        },
                        menuChildren: ["Dark", "Light", "System"].map((e) => MenuItemButton(
                          onPressed: () {
                            final b = getThemeMode(e);

                            Get.changeThemeMode(b);
                            Store.set(StoreKeys.theme, e);
                            debugPrint("SET THEME: ${Store.get(StoreKeys.theme)}");
                            profileController.themeMode.value = b;
                          },
                          child: Text(e, style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontFamily: appDefaultFont,
                            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
                          )),
                        )).toList()
                      )
                    ),
                    ListTile(
                      leading: const Icon(Icons.person_2_outlined),
                      title: const Text('Change Username'),
                      subtitle: Text(Global.user.username),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {

                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock_outline_rounded),
                      title: const Text('Change Password'),
                      subtitle: const Text('********'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {

                      }
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
