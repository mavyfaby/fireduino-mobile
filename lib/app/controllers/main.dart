import 'package:get/get.dart';

import '../models/department.dart';
import '../network/auth.dart';
import '../network/location.dart';
import '../network/request.dart';
import '../utils/dialog.dart';
import '../store/store.dart';
import '../models/edit_history.dart';
import '../models/incident.dart';
import '../utils/snackbar.dart';

import 'departments.dart';

class MainController extends GetxController {
  final pageStack = [1];
  final pageIndex = 1.obs;

  // Login History
  final loginHistoryList = [].obs;
  final loginSortColumnIndex = 1.obs;
  final loginSortAscending = false.obs;

  // Access Logs
  final accessLogsList = [].obs;
  final accessLogsSortColumnIndex = 1.obs;
  final accessLogsSortAscending = false.obs;

  // Incident Reports
  final incidentReportsList = <IncidentReport>[].obs;
  IncidentReport? openedIncidentReport;
  int? openedIncidentReportId;
  bool? isReportEditing;

  // Edit history
  final editHistoryList = <EditHistoryModel>[].obs;
  final editHistorySortColumnIndex = 1.obs;
  final editHistorySortAscending = false.obs;

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
      showAppDialog("Error ", FireduinoAPI.message);
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

  Future<void> fetchLoginHistory({ bool isShowLoader = true }) async {
    // Show dialog that we are fetching the latest login history
    if (isShowLoader) {
      showLoader("Fetching login history...");
    }

    // Fetch latest login history
    List<List<String>>? loginHistory = await FireduinoAPI.fetchLoginHistory();

    // Hide loader
    if (isShowLoader) {
      Get.back();
    }

    // If result is null
    if (loginHistory == null) {
      // Show error
      showAppDialog("Error ", FireduinoAPI.message);
      return;
    }

    // If result is empty
    if (loginHistory.isEmpty) {
      // Show error
      showAppDialog("Error ", "No login history found");
    }

    // Set login history
    loginHistoryList.assignAll(loginHistory);
  }

  Future<void> fetchAccessLogs({ bool isShowLoader = true }) async {
    // Show dialog that we are fetching the latest access logs
    if (isShowLoader) {
      showLoader("Fetching access logs...");
    }

    // Fetch latest access logs
    List<List<String>>? accessLogs = await FireduinoAPI.fetchAccessLogs();

    // Hide loader
    if (isShowLoader) {
      Get.back();
    }

    // If result is null
    if (accessLogs == null) {
      // Show error
      showAppDialog("Error ", FireduinoAPI.message);
      return;
    }

    // If result is empty
    if (accessLogs.isEmpty) {
      // Show error
      showAppDialog("Error ", "No access logs found");
    }

    // Set access logs
    accessLogsList.assignAll(accessLogs);
  }

  Future<void> fetchIncidentReports({ bool isShowLoader = true}) async {
    // Show dialog that we are fetching the latest incident reports
    if (isShowLoader) {
      showLoader("Fetching incident reports...");
    }
    
    // Fetch latest incident reports
    List<IncidentReport>? incidentReports = await FireduinoAPI.fetchIncidentReports();

    // Hide loader
    if (isShowLoader) {
      Get.back();
    }

    // If result is null
    if (incidentReports == null) {
      // Show error
      showAppDialog("Error ", FireduinoAPI.message);
      return;
    }

    // If result is empty
    if (incidentReports.isEmpty) {
      // Show error
      showAppSnackbar("No incident reports found");
    }

    // Set incident reports
    incidentReportsList.assignAll(incidentReports);
  }

  /// Fetch edit history
  Future<void> fetchEditHistory({ bool isShowLoader = true}) async {
    // Show dialog that we are fetching the latest incident reports
    if (isShowLoader) {
      showLoader("Fetching edit history...");
    }
    
    // Fetch latest incident reports
    List<EditHistoryModel>? history = await FireduinoAPI.fetchEditHistory();

    // Hide loader
    if (isShowLoader) {
      Get.back();
    }

    // If result is null
    if (history == null) {
      // Show error
      showAppDialog("Error ", FireduinoAPI.message);
      return;
    }

    // If result is empty
    if (history.isEmpty) {
      // Show error
      showAppSnackbar("No edit history found");
    }

    // Set incident reports
    editHistoryList.assignAll(history);
  }
}