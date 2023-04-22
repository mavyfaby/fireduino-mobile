import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/controllers/home.dart';
import 'app/controllers/login.dart';
import 'app/controllers/signup.dart';

import 'app/routes/routes.dart';
import 'app/store/auth.dart';
import 'app/env/config.dart';
import 'app/theme/theme.dart';

void main() async {
  // Ensure that the binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize GetStorage
  await GetStorage.init();
  // Initialize the auth store
  await FireduinoAuth.init();
  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(LoginController());
    Get.put(CreateAccountController());

    return GetMaterialApp(
      title: appName,
      initialRoute: '/home',
      getPages: Routes.get(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: Color.alphaBlend(
          lightColorScheme.primary.withOpacity(0.05),
          lightColorScheme.surface
        ),
        appBarTheme: AppBarTheme(
          elevation: 1,
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
        scaffoldBackgroundColor: Color.alphaBlend(
          darkColorScheme.primary.withOpacity(0.05),
          darkColorScheme.surface
        ),
        appBarTheme: AppBarTheme(
          elevation: 1,
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: darkColorScheme.onSurface,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
          ),
        ),
      )
    );
  }
}
