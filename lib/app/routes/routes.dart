import 'package:get/get.dart';

import '../views/home.dart';
import '../views/login.dart';
import '../views/signup.dart';

import 'middlewares.dart';

class Routes {
  static get() {
    return [
      GetPage(
        name: '/login',
        page: () => const LoginPage()
      ),
      GetPage(
        name: '/home',
        middlewares: [ SessionMiddleware() ],
        page: () => HomePage()
      ),
      GetPage(
        name: '/signup',
        page: () => const CreateAccountPage()
      ),
    ];
  }
}