import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/incident.dart';
import '../controllers/main.dart';
import '../utils/date.dart';

class IncidentReportCard extends StatelessWidget {
  const IncidentReportCard({ required this.id, required this.report, super.key});

  final int id;
  final IncidentReport report;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: InkWell(
          onTap: report.rid == null ? null : () {
            Get.find<MainController>().isReportEditing = true;
            Get.find<MainController>().openedIncidentReport = report;
            Get.find<MainController>().openedIncidentReportId = id;
    
            Get.toNamed('/incident');
          },
          child: Container(
            height: 250,
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('#$id', style: Theme.of(context).textTheme.titleMedium),
                        Text(getReadableDate(report.idate), style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    report.rid == null ? const Spacer() : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: Text(String.fromCharCodes(base64Decode(report.cause!)), style: Theme.of(context).textTheme.bodyMedium)
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Fireduino: ', style: Theme.of(context).textTheme.bodyMedium),
                            Text(report.deviceName, style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Fire Department:', style: Theme.of(context).textTheme.bodyMedium),
                            Text(report.deptName, style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        )
                      ]
                    ),
                  ],
                ),
                report.rid == null ? Center(
                  child: 
                    FilledButton.icon(
                    onPressed: () {
                      Get.find<MainController>().isReportEditing = false;
                      Get.find<MainController>().openedIncidentReport = report;
                      Get.find<MainController>().openedIncidentReportId = id;
              
                      Get.toNamed('/incident');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Report'),
                  ),
                ) : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
