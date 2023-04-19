import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../env/config.dart';

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
        
                Text("Fireduino", style: Get.textTheme.headlineLarge!.copyWith(
                  color: Get.theme.colorScheme.primary,
                  fontWeight: FontWeight.bold)
                ), 
                const SizedBox(height: 16),
                const Text(appTagline),

                const SizedBox(height: 32),
                const SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Username or Email",
                      prefixIcon: Icon(Icons.person_outline_rounded),
                      filled: true
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(
                  width: 300,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      filled: true
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                SizedBox(
                  width: 300,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {

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
                      
                },
                child: const Text("Forgot password")
              ),
            ),
          )
        ]
      )
    );
  }
}