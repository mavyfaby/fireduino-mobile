import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../network/request.dart';
import '../../utils/date.dart';
import '../../utils/dialog.dart';
import '../../controllers/main.dart';
import '../../utils/snackbar.dart';

class IncidentPage extends StatelessWidget {
  const IncidentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reportController = TextEditingController();
    final mainController = Get.find<MainController>();
    final report = mainController.openedIncidentReport;

    // If editing
    if (mainController.isReportEditing != null && mainController.isReportEditing!) {
      reportController.text = String.fromCharCodes(base64Decode(report!.cause!));
    }

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Incident ${mainController.openedIncidentReportId}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Center(
                    child: TextField(
                      autofocus: false,
                      controller: reportController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Enter your detailed incident report here...',
                      ),
                      maxLines: 100,
                    ),
                  ),
                )
              ],
            ),
          ),
          
          // Last saved text
          if (mainController.isReportEditing != null && mainController.isReportEditing!)
            Positioned(
              bottom: 32,
              left: 16,
              child: Text('Last saved ${getReadableDate(report!.rdate!)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // If empty report do nothing
          if (reportController.text.trim().isEmpty) {
            showAppSnackbar('Empty report!');
            return;
          }

          // Show loader
          showLoader("Saving report...");
          // Declare success flag
          bool success = false;

          // If editing
          if (mainController.isReportEditing != null && mainController.isReportEditing!) {
            success = await FireduinoAPI.editIncidentReport(report!.iid, report.rid!, reportController.text);
          } else {
            // Save report
            success = await FireduinoAPI.addIncidentReport(report!.iid, reportController.text);
          }

          // If success, remove focus
          if (success && FocusManager.instance.primaryFocus != null) {
            FocusManager.instance.primaryFocus!.unfocus();
          }

          // Hide loader
          Get.back();
          // If success
          await showAppDialog(success ? 'Report saved' : 'Error saving report', FireduinoAPI.message);

          // If success
          if (success) {
            // Fetch incident reports
            mainController.fetchIncidentReports();
            // Go back
            Get.back();
          }
        },
        elevation: 0,
        icon: const Icon(Icons.check_rounded),
        label: const Text('Save'),
      ),
    );
  }
}