import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/departments.dart';
import '../models/department.dart';
import '../network/request.dart';
import '../utils/dialog.dart';
import '../network/location.dart';
import '../controllers/home.dart';
import '../controllers/main.dart';
import '../widgets/drawer.dart';
import '../store/global.dart';

import 'home/home.dart';
import 'departments/departments.dart';
import 'incident_reports/incident_reports.dart';
import 'access_logs/access_logs.dart';
import 'edit_history/edit_history.dart';
import 'login_history/login_history.dart';
import 'sms_history/sms_history.dart';
import 'preferences/preferences.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();
    final homeController = Get.find<HomeController>();

    final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

    final pages = [
      const HomePage(),
      const FireDepartmentsView(),
      const IncidentReportsView(),
      const AccessLogsView(),
      const EditHistoryView(),
      const LoginHistoryView(),
      const SMSHistoryView(),
      const PreferencesView()
    ];

    return WillPopScope(
      onWillPop: () async {
        if (mainController.pageStack.length == 1) {
          return true;
        }
        
        mainController.pageStack.removeLast();
        mainController.pageIndex.value = mainController.pageStack.last;

        return false;
      },
      child: Scaffold(
        key: drawerKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              drawerKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          title: Obx(() => Text(
            mainController.pageIndex.value == 0 ?
              homeController.pageIndex.value == 0 ?
                "Dashboard" :
                "Fireduinos" : 
              mainController.pageIndex.value >= Global.drawerItems.length ?
                "Preferences" :
                Global.drawerItems[mainController.pageIndex.value]["title"],
          )),
        ),
    
        drawer: FireduinoDrawer(
          onSelect: (index) async {
            // If selecting, Fire departments, request location permission
            if (index == 1) {
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
              Get.find<FireDepartmentsController>().fireDepartments.value = departments;
            }

            homeController.pageIndex.value = 0;
            mainController.pageStack.add(index);
            mainController.pageIndex.value = index;
          },
        ),
      
        body: Obx(() => pages[mainController.pageIndex.value]),
      )
    );
  }
}