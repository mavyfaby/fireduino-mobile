import 'package:fireduino/app/store/store.dart';
import 'package:get/get.dart';

import '../network/auth.dart';

class MainController extends GetxController {
  final pageStack = [0];
  final pageIndex = 0.obs;

  void logout() async {
    // Clear user data
    Store.remove(StoreKeys.user);
    Store.remove(StoreKeys.loginToken);
    // Reset Main controller index
    pageIndex.value = 0;
    // Init auth
    await FireduinoAuth.init();
    // Go to main path
    Get.offAllNamed('/main');
  }
}