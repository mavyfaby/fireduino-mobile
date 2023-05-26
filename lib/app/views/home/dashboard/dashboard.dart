import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../../../controllers/home.dart';
import '../../../controllers/main.dart';
import '../../../store/global.dart';
import '../../../controllers/dashboard.dart';
import '../../../env/config.dart';
import '../../../utils/date.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dash = Get.find<DashController>();

    return FutureBuilder(
      future: dash.fetchDashboardData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If has error
          if (snapshot.hasError) {
            return const Center(child: Text("An error has occured!"));
          }

          // If successful
          return RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {
              await dash.fetchDashboardData();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  AlignedGridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Obx(() => DashData(
                        index: index,
                        title: index == 0 ? "Total Fireduinos" : "Fire Departments",
                        value: index == 0 ? dash.fireduinos.value : dash.departments.value
                      ));
                    },
                  ),
                  const SizedBox(height: 16),
                  DashIncidentReports(),
                  const SizedBox(height: 16),
                  Center(
                    child: Obx(() => Text(
                      "As of ${getReadableDate(dash.date.value)}",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontFamily: appDefaultFont,
                        color: Theme.of(context).colorScheme.secondary
                      )
                    ))
                  )
                ],
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class DashData extends StatelessWidget {
  const DashData({
    required this.index,
    required this.title,
    required this.value,
    super.key
  });

  final String title;
  final int value;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Theme.of(context).brightness == Brightness.light ?
        Theme.of(context).colorScheme.onInverseSurface :
        Theme.of(context).colorScheme.surfaceVariant,
      child: InkWell(
        onTap: () async {
          if (index == 0) {
            Get.find<HomeController>().pageIndex.value = 1;
            Get.find<HomeController>().pageController.animateToPage(1,
              duration: const Duration(milliseconds: 210),
              curve: Curves.easeInOut
            );

            return;
          }

          await Get.find<MainController>().fetchFireDepartments(null);
          await Get.find<MainController>().fetchEstablishment(Global.user.eid!);
          Get.find<MainController>().pageStack.add(2);
          Get.find<MainController>().pageIndex.value = 2;
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(value == -1 ? "..." : "$value", style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontFamily: appDefaultFont,
                color: Theme.of(context).colorScheme.inverseSurface,
                fontWeight: FontWeight.bold
              )),
              const SizedBox(height: 4),
              Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontFamily: appDefaultFont,
                color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.6),
              )),
            ],
          )
        ),
      )
    );
  }
} 

// ignore: must_be_immutable
class DashIncidentReports extends StatelessWidget {
  DashIncidentReports({super.key});

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final dash = Get.find<DashController>();

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Theme.of(context).brightness == Brightness.light ?
        Theme.of(context).colorScheme.onInverseSurface :
        Theme.of(context).colorScheme.surfaceVariant,
      child: InkWell(
        onTap: () async {
          await Get.find<MainController>().fetchIncidentReports();
          Get.find<MainController>().pageStack.add(3);
          Get.find<MainController>().pageIndex.value = 3;
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Incident Reports", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontFamily: appDefaultFont,
                    color: Theme.of(context).colorScheme.inverseSurface,
                    fontWeight: FontWeight.bold
                  )),
                  const Spacer(),
                  MenuAnchor(
                    builder: (context, controller, child) {
                      return TextButton(
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        child: Obx(() => Text(
                          '${dash.year.value}',
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontFamily: appDefaultFont,
                            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
                          )
                        )),
                      );
                    },
                    menuChildren: getYears().map((e) => MenuItemButton(
                      child: Text("$e"),
                      onPressed: () {
                        dash.year.value = e;
                        dash.fetchDashboardData(true);
                      },
                    )).toList()
                  ),
                  MenuAnchor(
                    builder: (context, controller, child) {
                      return TextButton(
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        child: Obx(() => Text(dash.isQuarter12.value ? 'Q1-2' : 'Q3-4', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontFamily: appDefaultFont,
                          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
                        ))),
                      );
                    },
                    menuChildren: [
                      MenuItemButton(
                        child: const Text("Q1-2"),
                        onPressed: () {
                          dash.isQuarter12.value = true;
                          dash.fetchDashboardData(true);
                        },
                      ),
                      MenuItemButton(
                        child: const Text("Q3-4"),
                        onPressed: () {
                          dash.isQuarter12.value = false;
                          dash.fetchDashboardData(true);
                        },
                      ),
                    ]
                  )
                ],
              ),
              const SizedBox(height: 20),
              AspectRatio(
                aspectRatio: 2,
                child: Obx(() => BarChart(
                  BarChartData(
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipMargin: 0,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            rod.toY.round().toString(),
                            TextStyle(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                dash.incidents[value.toInt()].toString(),
                                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  fontFamily: appDefaultFont,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.6),
                                )
                              )
                            );
                          }
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Obx(() => Text(
                                Global.months[value.toInt() + (dash.isQuarter12.value ? 0 : 6)].toString(),
                                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  fontFamily: appDefaultFont,
                                  color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.6),
                                )
                              ))
                            );
                          },
                          reservedSize: 38,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: List.generate(dash.incidents.length, (index) => BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: dash.incidents[index].toDouble(),
                          color: Theme.of(context).colorScheme.primary,
                          width: 20,
                          borderRadius: BorderRadius.circular(11),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: 10,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          ),
                        ),
                      ],
                    )),
                    gridData: FlGridData(show: false),
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.linear, // Optional
                ))
              )
            ],
          ),
        ),
      ),
    );
  }
}