import 'package:get/get.dart';

import '../models/department.dart';
import '../network/auth.dart';
import '../network/location.dart';
import '../network/request.dart';
import '../utils/dialog.dart';
import '../store/store.dart';

import 'departments.dart';

class MainController extends GetxController {
  final pageStack = [0];
  final pageIndex = 1.obs;

  void logout() async {
    // Clear user data
    Store.remove(StoreKeys.user);
    Store.remove(StoreKeys.loginToken);
    // Reset Main controller index
    pageIndex.value = 1;
    // Init auth
    await FireduinoAuth.init();
    // Go to main path
    Get.offAllNamed('/main');
  }

  Future<void> fetchFireDepartments() async {
    await FireduinoLocation.ensureLocationServiceEnabled();
    await FireduinoLocation.ensureLocationPermissionAccepted();

    //  Show dialog that we are fetching the latest fire departments
    showLoader("Getting latest fire departments...");
    // Fetch latest fire departments
    List<FireDepartmentModel>? departments = await FireduinoAPI.fetchFireDepartments();
    // Hide loader
    Get.back();

    // If result is null
    if (departments == null) {
      // Show error
      showAppDialog("Error ", "Failed to fetch fire departments");
      return;
    }

    // If result is empty
    if (departments.isEmpty) {
      // Show error
      showAppDialog("Error ", "No fire departments found");
    }

    // Set fire departments
    Get.find<FireDepartmentsController>().fireDepartments.assignAll(departments);
}
}