import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/controllers/home.dart';
import 'app/controllers/login.dart';
import 'app/controllers/signup.dart';

import 'app/store/global.dart';
import 'app/network/socket.dart';
import 'app/theme/helpers.dart';
import 'app/routes/routes.dart';
import 'app/store/auth.dart';
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

    Get.put(HomeController());
    Get.put(LoginController());
    Get.put(CreateAccountController());

    return GetMaterialApp(
      title: appName,
      initialRoute: '/home',
      getPages: Routes.get(),
      theme: theme['light'],
      darkTheme: theme['dark']
    );
  }
}
