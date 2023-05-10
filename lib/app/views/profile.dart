import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../store/global.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  color: Get.theme.brightness == Brightness.light ?
                    Get.theme.colorScheme.onSurfaceVariant :
                    Get.theme.colorScheme.secondary,
                  size: 150,
                ),
                const SizedBox(height: 8),
                Text("${Global.user.firstName} ${Global.user.lastName}" , style: Get.textTheme.headlineSmall),
                const SizedBox(height: 16),
                Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.dark_mode_outlined),
                      title: const Text('Dark Mode'),
                      trailing: Switch(value: false, onChanged: (v) {}),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person_2_outlined),
                      title: const Text('Username'),
                      subtitle: Text(Global.user.username),
                      trailing: const Icon(Icons.arrow_right),
                    ),
                    const ListTile(
                      leading: Icon(Icons.lock_outline_rounded),
                      title: Text('Password'),
                      subtitle: Text('********'),
                      trailing: Icon(Icons.arrow_right),
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
