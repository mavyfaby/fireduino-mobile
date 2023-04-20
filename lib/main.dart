import 'package:fireduino/app/controllers/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/env/config.dart';
import 'app/theme/theme.dart';

import 'app/views/home.dart';
import 'app/views/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return GetMaterialApp(
      title: appName,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: "Poppins",
        scaffoldBackgroundColor: Color.alphaBlend(
          lightColorScheme.primary.withOpacity(0.05),
          lightColorScheme.surface
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: lightColorScheme.onSurface,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: "Poppins",
        scaffoldBackgroundColor: Color.alphaBlend(
          darkColorScheme.primary.withOpacity(0.05),
          darkColorScheme.surface
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: darkColorScheme.onSurface,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
