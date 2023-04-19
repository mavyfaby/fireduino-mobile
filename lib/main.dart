import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/env/config.dart';
import 'app/theme/theme.dart';
import 'app/views/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: "Poppins"
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: "Poppins"
      ),
      home: const LoginPage(),
    );
  }
}
