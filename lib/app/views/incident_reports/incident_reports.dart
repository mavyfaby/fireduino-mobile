import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controllers/main.dart';
import '../../widgets/incident_card.dart';

class IncidentReportsView extends StatelessWidget {
  const IncidentReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await mainController.fetchIncidentReports(isShowLoader: false);
        },
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Obx(() => mainController.incidentReportsList.isNotEmpty ? ListView.builder(
            itemCount: mainController.incidentReportsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 16 : 0, bottom: 16.0),
                child: IncidentReportCard(
                  id: mainController.incidentReportsList.length - index,
                  report: mainController.incidentReportsList[index]
                )
              );
            },
          ) : Stack(
            children: [
              ListView(),
              Center(
                child: Text('No incident reports found', style: Theme.of(context).textTheme.bodyMedium)
              )
            ],
          )
        )),
      )
    );
  }
}
