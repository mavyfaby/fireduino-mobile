import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main.dart';
import '../../utils/date.dart';

class SMSHistoryView extends StatelessWidget {
  const SMSHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();

    return Scaffold(
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          await Get.find<MainController>().fetchSmsHistory(isShowLoader: false);
        },
        child: SizedBox.expand(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            // ignore: invalid_use_of_protected_member
            child: Obx(() => SmsHistroyTable(data: mainController.smsHistoryList.value)),
          ),
        ),
      ),
    );
  }
}

class SmsHistroyTable extends StatelessWidget {
  const SmsHistroyTable({ required this.data, super.key });

  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          cardTheme: Theme.of(context).cardTheme.copyWith(
            color: Theme.of(context).brightness == Brightness.light ?
              Theme.of(context).colorScheme.onInverseSurface :
              Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.7),
          ),
          dividerTheme: Theme.of(context).dividerTheme.copyWith(
            color: Theme.of(context).brightness == Brightness.light ?
              Theme.of(context).colorScheme.outlineVariant :
              Theme.of(context).colorScheme.outline.withOpacity(0.4),
          ),
        ),
        child: Obx(() => PaginatedDataTable(
          sortColumnIndex: Get.find<MainController>().smsHistorySortColumnIndex.value,
          sortAscending: Get.find<MainController>().smsHistorySortAscending.value,
          rowsPerPage: 10,
          columns: <DataColumn>[
            DataColumn(label: const Text('Fire Department'), onSort: onSort),
            DataColumn(label: const Text('Date & Time'), onSort: onSort),
          ],
          source: _DataSource(data),
        )),
      ),
    );
  }

  /// Sort table
  void onSort(int columnIndex, bool ascending) {
    Get.find<MainController>().smsHistorySortAscending.value = ascending;
    Get.find<MainController>().smsHistorySortColumnIndex.value = columnIndex;

    if (Get.find<MainController>().smsHistorySortColumnIndex.value == 0) {
      data.sort((a, b) => a[0].compareTo(b[0]));
    } else if (Get.find<MainController>().smsHistorySortColumnIndex.value == 1) {
      data.sort((a, b) => a[1].compareTo(b[1]));
    }

    if (!Get.find<MainController>().smsHistorySortAscending.value) {
      data.assignAll(data.reversed.toList());
    }
  }
}

class _DataSource extends DataTableSource {

  _DataSource(this.data);

  final List<dynamic> data;

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(data[index].deptName)),
        DataCell(Text(getReadableDate(data[index].date))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}