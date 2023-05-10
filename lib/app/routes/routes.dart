import 'package:fireduino/app/views/profile/profile.dart';
import 'package:get/get.dart';

import '../views/add.dart';
import '../views/login.dart';
import '../views/main.dart';
import '../views/scan.dart';
import '../views/signup.dart';

import '../views/home/fireduinos/fireduino/fireduino.dart';

import 'middlewares.dart';

class Routes {
  static List<GetPage> get() {
    return [
      GetPage(
        name: '/login',
        page: () => const LoginPage()
      ),
      GetPage(
        name: '/main',
        middlewares: [ SessionMiddleware() ],
        page: () => const MainPage()
      ),
      GetPage(
        name: '/add',
        page: () => const AddFireduinoPage()
      ),
      GetPage(
        name: '/scan',
        page: () => const ScanPage()
      ),
      GetPage(
        name: '/signup',
        page: () => const CreateAccountPage()
      ),
      GetPage(
        name: '/fireduino',
        page: () => const FireduinoPage()
      ),
      GetPage(
        name: '/profile',
        page: () => const ProfilePage()
      ),
    ];
  }
}