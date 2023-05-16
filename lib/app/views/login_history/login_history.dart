import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main.dart';

class LoginHistoryView extends StatelessWidget {
  const LoginHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();

    return Scaffold(
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          await Get.find<MainController>().fetchLoginHistory(isShowLoader: false);
        },
        child: SizedBox.expand(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            // ignore: invalid_use_of_protected_member
            child: Obx(() => LoginHistoryTable(data: mainController.loginHistoryList.value)),
          ),
        ),
      ),
    );
  }
}

class LoginHistoryTable extends StatelessWidget {
  const LoginHistoryTable({ required this.data, super.key });

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
          sortColumnIndex: Get.find<MainController>().loginSortColumnIndex.value,
          sortAscending: Get.find<MainController>().loginSortAscending.value,
          rowsPerPage: 10,
          columns: <DataColumn>[
            DataColumn(label: const Text('Date'), onSort: onSort),
            DataColumn(label: const Text('Time'), onSort: onSort),
          ],
          source: _DataSource(data),
        )),
      ),
    );
  }

  /// Sort table
  void onSort(int columnIndex, bool ascending) {
    Get.find<MainController>().loginSortAscending.value = ascending;
    Get.find<MainController>().loginSortColumnIndex.value = columnIndex;

    if (Get.find<MainController>().loginSortColumnIndex.value == 0) {
      data.sort((a, b) => a[0].compareTo(b[0]));
    } else if (Get.find<MainController>().loginSortColumnIndex.value == 1) {
      data.sort((a, b) => a[1].compareTo(b[1]));
    }

    if (!Get.find<MainController>().loginSortAscending.value) {
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
        DataCell(Text(data[index][0])),
        DataCell(Text(data[index][1])),
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