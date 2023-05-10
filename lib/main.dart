import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/controllers/fireduinos.dart';
import 'app/controllers/home.dart';
import 'app/controllers/login.dart';
import 'app/controllers/main.dart';
import 'app/controllers/signup.dart';
import 'app/controllers/profile.dart';
import 'app/controllers/dashboard.dart';
import 'app/controllers/departments.dart';

import 'app/store/global.dart';
import 'app/network/socket.dart';
import 'app/theme/helpers.dart';
import 'app/routes/routes.dart';
import 'app/network/auth.dart';
import 'app/env/config.dart';

void main() async {
  // Ensure that the binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize GetStorage
  await GetStorage.init();
  // Initialize the auth store
  await FireduinoAuth.init();
  // Get platform information
  await Global.initDeviceInfo();
  // Connect to the socket server
  FireduinoSocket.instance.connect();
  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = getTheme(context);

    Get.put(MainController());
    Get.put(HomeController());
    Get.put(DashController());
    Get.put(LoginController());
    Get.put(ProfileController());
    Get.put(CreateAccountController());
    Get.put(FireduinosController());
    Get.put(FireDepartmentsController());


    return GetMaterialApp(
      title: appName,
      initialRoute: '/main',
      getPages: Routes.get(),
      theme: theme['light'],
      darkTheme: theme['dark'],
      themeMode: Global.themeMode,
    );
  }
}