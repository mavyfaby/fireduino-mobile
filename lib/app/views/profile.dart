import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../network/request.dart';
import '../utils/snackbar.dart';
import '../custom/decoration.dart';
import '../store/store.dart';
import '../controllers/profile.dart';
import '../env/config.dart';
import '../store/global.dart';
import '../utils/dialog.dart';
import '../utils/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the profile controller
    final profileController = Get.find<ProfileController>();
    // Set the initial value of the dark mode switch
    profileController.themeMode.value = Global.themeMode;
    profileController.username.value = Global.user.username;

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
                Opacity(
                  opacity: 0.7,
                  child: Text(Global.user.email, style: Get.textTheme.titleSmall!.copyWith(
                    fontFamily: appDefaultFont,
                  )),
                ),
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
                      subtitle: Obx(() => Text(profileController.username.value)),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: showUpdateUsername,
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock_outline_rounded),
                      title: const Text('Change Password'),
                      subtitle: const Text('••••••••'),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: showUpdatePassword
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

  void showUpdateUsername() {
    final usernameController = TextEditingController(text: Global.user.username);

    Get.dialog(AlertDialog(
      title: const Text("Change Username"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            maxLength: 32,
            controller: usernameController,
            decoration: CustomInputDecoration(
              prefixIcon: const Icon(Icons.person_outline_rounded),
              context: Get.context!,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel")
        ),
        TextButton(
          onPressed: () async {
            // Show loader
            showLoader("Updating username...");
            // Update the username
            bool isSuccess = await FireduinoAPI.updateUser(1, usernameController.text);
            // Hide loader
            Get.back();

            if (isSuccess) {
              // Update the username
              Get.find<ProfileController>().username.value = usernameController.text;
              // Get user from store
              final user = Global.user.toJson();
              // Update the username
              user["c"] = usernameController.text;
              // Update the user in the store
              Store.set(StoreKeys.user, user);
              // Show success message
              showAppSnackbar(FireduinoAPI.data);
              // Close the dialog
              return Get.back();
            }

            // Show error message
            showAppDialog("Error", FireduinoAPI.message);
          },
          child: const Text("Save")
        )
      ],
    ));
  }

  void showUpdatePassword() {
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final errorMessage = "".obs;

    final isPassVisible = false.obs;
    final isPassConfirmVisible = false.obs;

    Get.dialog(AlertDialog(
      title: const Text("Change Password"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => TextField(
            maxLength: 32,
            controller: passwordController,
            obscureText: !isPassVisible.value,
            decoration: CustomInputDecoration(
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              context: Get.context!,
              labelText: "New Password",
              suffixIcon: IconButton(
                icon: Icon(isPassVisible.value ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  isPassVisible.value = !isPassVisible.value;
                },
              ),
            ),
          )),
          const SizedBox(height: 8),
          Obx(() => TextField(
            maxLength: 32,
            controller: confirmPasswordController,
            obscureText: !isPassConfirmVisible.value,
            decoration: CustomInputDecoration(
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              context: Get.context!,
              errorText: errorMessage.value.isNotEmpty ? errorMessage.value : null,
              labelText: "Confirm Password",
              suffixIcon: IconButton(
                icon: Icon(isPassConfirmVisible.value ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  isPassConfirmVisible.value = !isPassConfirmVisible.value;
                },
              ),
            ),
          )),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel")
        ),
        TextButton(
          onPressed: () async {
            errorMessage.value = "";

            if (passwordController.text.isEmpty) {
              errorMessage.value = "Password cannot be empty.";
              return;
            }

            if (passwordController.text.length < 8) {
              errorMessage.value = "Password must be at least 8 characters.";
              return;
            }

            if (passwordController.text != confirmPasswordController.text) {
              errorMessage.value = "Passwords do not match.";
              return;
            }

            // Show loader
            showLoader("Updating password...");
            // Update the password
            bool isSuccess = await FireduinoAPI.updateUser(2, passwordController.text);
            // Hide loader
            Get.back();

            if (isSuccess) {
              // Show success message
              showAppSnackbar(FireduinoAPI.data);
              // Close the dialog
              return Get.back();
            }

            // Show error message
            showAppDialog("Error", FireduinoAPI.message);
          },
          child: const Text("Save")
        )
      ],
    ));
  }
}
