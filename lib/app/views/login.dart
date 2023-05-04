import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../network/socket.dart';
import '../store/auth.dart';
import '../store/store.dart';
import '../models/user.dart';
import '../network/request.dart';
import '../utils/dialog.dart';
import '../controllers/login.dart';
import '../custom/decoration.dart';
import '../env/config.dart';

import 'signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/svg/fireduino_icon.svg"),
                const SizedBox(height: 16),
        
                Text("Fireduino", style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Get.theme.colorScheme.primary,
                  fontWeight: FontWeight.bold)
                ), 
                const SizedBox(height: 16),
                const Text(appTagline),

                const SizedBox(height: 32),
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: CustomInputDecoration(
                      context: context,
                      labelText: "Username or email",
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                    ),
                    onChanged: (value) {
                      loginController.username.value = value;
                    },
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    obscureText: true,
                    decoration: CustomInputDecoration(
                      context: context,
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                    ),
                    onChanged: (value) {
                      loginController.password.value = value;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: Obx(() => FilledButton(
                    onPressed: loginController.username.value.isNotEmpty && loginController.password.value.isNotEmpty ? () async {
                      // If username or password is empty, show error
                      if (loginController.username.value.isEmpty || loginController.password.value.isEmpty) {
                        showAppDialog("Error", "Please enter your username and password");
                        return;
                      }

                      // Show loader
                      showLoader("Logging in...");
                      // Login user
                      UserModel? user = await FireduinoAPI.login(loginController.username.value, loginController.password.value);

                      // If user is null
                      if (user == null) {
                        // Hide loader
                        Get.back();
                        // Show error
                        showAppDialog("Error", FireduinoAPI.message);
                        return;
                      }

                      // Store token
                      Store.set(StoreKeys.loginToken, FireduinoAPI.component);
                      // Save user
                      Store.set(StoreKeys.user, user.toJson());
                      // Load auth
                      await FireduinoAuth.init();
                      // Connect to the socket server
                      FireduinoSocket.instance.connect();
                      // Go to home page
                      Get.toNamed("/main");
                    } : null,
                    child: const Text("Login")
                  )),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: TextButton(
                onPressed: () {
                  Get.to(() => const CreateAccountPage());
                },
                child: const Text("Create an account")
              ),
            ),
          )
        ]
      )
    );
  }
}