import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../custom/decoration.dart';
import '../env/config.dart';

import 'home.dart';
import 'signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    )
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  child: TextField(
                    obscureText: true,
                    decoration: CustomInputDecoration(
                      context: context,
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                    )
                  ),
                ),
                const SizedBox(height: 32),

                SizedBox(
                  width: 300,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      Get.to(() => HomePage());
                    },
                    child: const Text("Login")
                  ),
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