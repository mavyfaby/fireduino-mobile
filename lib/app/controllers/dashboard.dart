import 'package:get/get.dart';

import '../models/dashboard.dart';
import '../network/request.dart';
import '../utils/dialog.dart';
import '../utils/snackbar.dart';

class DashController extends GetxController {
  final RxInt fireduinos = (-1).obs;
  final RxInt departments= (-1).obs;

  final RxInt year = DateTime.now().year.obs;
  final Rx<DateTime> date = DateTime.now().obs;
  final RxBool isQuarter12 = true.obs;
  
  final List<int> incidents = [
    0, 0, 0, 0 ,0, 0
  ].obs;

  /// Fetches dashboard data from the server
  Future<void> fetchDashboardData([ bool isShowLoader = false ]) async {
    // If show loader
    if (isShowLoader) {
      // Show loader
      showLoader("Fetching dashboard data...");
    }

    // Fetch dashboard data
    DashboardDataModel? dashData = await FireduinoAPI.fetchDashboardData(year.value, isQuarter12.value);

    // If show loader
    if (isShowLoader) {
      // Hide loader
      Get.back();
    }

    // If data is null
    if (dashData == null) {
      showAppSnackbar(FireduinoAPI.message);
      return;
    }

    // Set data
    date.value = dashData.date;
    fireduinos.value = dashData.devices;
    departments.value = dashData.departments;
    incidents.assignAll(dashData.incidents);
  }
}