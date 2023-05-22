import 'package:fireduino/app/models/edit_history.dart';
import 'package:fireduino/app/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main.dart';

class EditHistoryView extends StatelessWidget {
  const EditHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();

    return Scaffold(
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          await Get.find<MainController>().fetchEditHistory(isShowLoader: false);
        },
        child: SizedBox.expand(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            // ignore: invalid_use_of_protected_member
            child: Obx(() => EditHistoryTable(data: mainController.editHistoryList.value)),
          ),
        ),
      ),
    );
  }
}

class EditHistoryTable extends StatelessWidget {
  const EditHistoryTable({ required this.data, super.key });

  final List<EditHistoryModel> data;

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
          sortColumnIndex: Get.find<MainController>().editHistorySortColumnIndex.value,
          sortAscending: Get.find<MainController>().editHistorySortAscending.value,
          rowsPerPage: 10,
          columns: <DataColumn>[
            DataColumn(label: const Text('Type'), onSort: onSort),
            DataColumn(label: const Text('Before'), onSort: onSort),
            DataColumn(label: const Text('After'), onSort: onSort),
            DataColumn(label: const Text('Date'), onSort: onSort),
          ],
          source: _DataSource(data),
        )),
      ),
    );
  }

  /// Sort table
  void onSort(int columnIndex, bool ascending) {
    Get.find<MainController>().editHistorySortAscending.value = ascending;
    Get.find<MainController>().editHistorySortColumnIndex.value = columnIndex;

    if (Get.find<MainController>().editHistorySortColumnIndex.value == 0) {
      data.sort((a, b) => a.name.compareTo(b.name));
    } else if (Get.find<MainController>().editHistorySortColumnIndex.value == 1) {
      data.sort((a, b) => a.before.compareTo(b.before));
    } else if (Get.find<MainController>().editHistorySortColumnIndex.value == 2) {
      data.sort((a, b) => a.after.compareTo(b.after));
    } else if (Get.find<MainController>().editHistorySortColumnIndex.value == 3) {
      data.sort((a, b) => a.date.compareTo(b.date));
    }

    if (!Get.find<MainController>().editHistorySortAscending.value) {
      data.assignAll(data.reversed.toList());
    }
  }
}

class _DataSource extends DataTableSource {

  _DataSource(this.data);

  final List<EditHistoryModel> data;

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(data[index].name)),
        DataCell(Text(data[index].before)),
        DataCell(Text(data[index].after)),
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