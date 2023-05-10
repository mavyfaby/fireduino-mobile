import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home.dart';

import 'dashboard/dashboard.dart';
import 'fireduinos/fireduinos.dart';

class HomePage extends StatelessWidget {
  const HomePage({ super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Scaffold(
      body: PageView(
        controller: homeController.pageController,
        onPageChanged: (value) {
          homeController.pageIndex.value = value;
        },
        children: const [
          DashboardPage(),
          FireduinosPage(),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed('/add');
        },
        elevation: 0,
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
        ))
      )
    );
  }
}