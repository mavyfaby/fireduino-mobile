import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../env/config.dart';
import '../store/global.dart';
import '../controllers/home.dart';

import 'dashboard/dashboard.dart';
import 'fireduinos/fireduinos.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final GlobalKey<ScaffoldState> drawerKey = GlobalKey();
    final PageController pageController = PageController();

    return Scaffold(
      key: drawerKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            drawerKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: Obx(() => Text(
          homeController.pageIndex.value == 0 ? "Dashboard" : "Fireduinos"
        )),
      ),

      drawer: Drawer(
        child: SafeArea(
          child: NavigationDrawer(
            selectedIndex: 0,
            onDestinationSelected: (int index) {
              
            },
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(appName, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Image.asset('assets/png/fireduino_icon.png', width: 32),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Global.user.getFullname(), style: Theme.of(context).textTheme.titleMedium),
                            Text(Global.user.getEmail(), style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontFamily: "Roboto"
                            ))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                  ], 
                ),
              ),
              
              ...Global.drawerItems.map((e) => NavigationDrawerDestination(
                icon: Icon(e['icon']),
                label: Text(e['title']),
                selectedIcon: Icon(e['sicon']),
              )).toList(),
              
              const Padding(
                padding:EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
                child: Divider(height: 1)
              ),

              const NavigationDrawerDestination(
                label:Text("Preferences"),
                icon: Icon(Icons.settings_suggest_outlined),
                selectedIcon:Icon(Icons.settings_suggest_rounded),
              ),

              const NavigationDrawerDestination(
                label:Text("Logout"),
                icon: Icon(Icons.logout_outlined),
                selectedIcon:Icon(Icons.logout_rounded),
              ),
            ]
          ),
        )
      ),
    
      body: PageView(
        controller: pageController,
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
                pageController.animateToPage(0,
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
                pageController.animateToPage(1,
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