import 'package:fireduino/app/store/global.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../../../controllers/dashboard.dart';
import '../../../env/config.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dash = Get.find<DashController>();

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
                  title: index == 0 ? "Total Fireduinos" : "Fire Departments",
                  value: index == 0 ? dash.fireduinos.value : dash.departments.value
                ));
              },
            ),
            const SizedBox(height: 16),
            DashIncidentReports(),
          ],
        ),
      ),
    );
  }
}

class DashData extends StatelessWidget {
  const DashData({super.key, required this.title, required this.value});

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Get.theme.brightness == Brightness.light ?
        Get.theme.colorScheme.primaryContainer :
        Get.theme.colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(value == -1 ? "..." : "$value", style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontFamily: appDefaultFont,
              color: Get.theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold
            )),
            const SizedBox(height: 4),
            Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontFamily: appDefaultFont,
              color: Get.theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
            )),
          ],
        )
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
      color: Get.theme.brightness == Brightness.light ?
        Get.theme.colorScheme.primaryContainer :
        Get.theme.colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Incident Reports", style: Get.theme.textTheme.titleLarge!.copyWith(
                  fontFamily: appDefaultFont,
                  color: Get.theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold
                )),
                TextButton(
                  onPressed: () {
                    dash.isQuarter12.value = !dash.isQuarter12.value;
                  },
                  child: const Text("2023 Q12", style: TextStyle(
                    fontFamily: appDefaultFont,
                  )),
                )
              ],
            ),
            const SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 2,
              child: BarChart(
                BarChartData(
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.transparent,
                      tooltipMargin: 0,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return null;
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
                              dash.data[value.toInt()].toString(),
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontFamily: appDefaultFont,
                                fontWeight: FontWeight.bold,
                                color: Get.theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
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
                                color: Get.theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
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
                  barGroups: List.generate(dash.data.length, (index) => BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: dash.data[index].toDouble(),
                        color: Get.theme.colorScheme.primary,
                        width: 20,
                        borderRadius: BorderRadius.circular(11),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: 10,
                          color: Get.theme.colorScheme.primary.withOpacity(0.1),
                        ),
                      ),
                    ],
                  )),
                  gridData: FlGridData(show: false),
                ),
                swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
              )
            )
          ],
        ),
      )
    );
  }
}