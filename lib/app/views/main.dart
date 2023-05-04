import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          onSelect: (index) {
            homeController.pageIndex.value = 0;
            mainController.pageStack.add(index);
            mainController.pageIndex.value = index;
          },
        ),
      
        body: Obx(() => pages[mainController.pageIndex.value]),
      
        floatingActionButton: Obx(() => AnimatedSlide(
          offset: Offset(0, mainController.pageIndex.value == 0 ? 0 : 100),
          duration: const Duration(seconds: 0),
          child: FloatingActionButton.extended(
            onPressed: () {
              Get.toNamed('/add');
            },
            elevation: 0,
            icon: const Icon(Icons.add),
            label: const Text("Fireduino"),
          ),
        )),
      
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      
        bottomNavigationBar: Obx(() => AnimatedSlide(
          offset: Offset(0, mainController.pageIndex.value == 0 ? 0 : 100),
          duration: const Duration(seconds: 0),
          child: BottomAppBar(
            elevation: 1,
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    homeController.pageIndex.value = 0;
                    homeController.pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 210),
                      curve: Curves.easeInOut
                    );
                  },
                  isSelected: homeController.pageIndex.value == 0,
                  icon: const Icon(Icons.dashboard_outlined),
                  selectedIcon: const Icon(Icons.dashboard_rounded),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    homeController.pageIndex.value = 1;
                    homeController.pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 210),
                      curve: Curves.easeInOut
                    );
                  },
                  isSelected: homeController.pageIndex.value == 1,
                  icon: const Icon(Icons.fireplace_outlined),
                  selectedIcon: const Icon(Icons.fireplace_rounded),
                ),
              ],
            )),
          ),
        ))
      ),
    );
  }
}