import 'package:fireduino/app/controllers/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard/dashboard.dart';
import 'fireduinos/fireduinos.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            _drawerKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: Obx(() => Text(
          homeController.pageIndex.value == 0 ? "Dashboard" : "Fireduinos"
        )),
      ),
      drawer: const Drawer(
        child: Center(
          child: Text("Drawer content"),
        ),
      ),
    
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          homeController.pageIndex.value = value;
        },
        children: const [
          DashboardPage(),
          FireduinosPage(),
        ],
      ),
    
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text("Fireduino"),
      ),
    
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                homeController.pageIndex.value = 0;
                _pageController.animateToPage(0,
                  duration: const Duration(milliseconds: 300),
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
                _pageController.animateToPage(1,
                  duration: const Duration(milliseconds: 300),
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
    );
  }
}