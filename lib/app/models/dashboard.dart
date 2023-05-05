class DashboardDataModel {
  final int devices;
  final int departments;
  final List<int> incidents;
  final DateTime date;

  DashboardDataModel({
    required this.devices,
    required this.departments,
    required this.incidents,
    required this.date,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) {
    return DashboardDataModel(
      devices: json['devices'],
      departments: json['departments'],
      incidents: json['incidents'].cast<int>(),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'devices': devices,
      'departments': departments,
      'incidents': incidents,
      'date': date.toIso8601String(),
    };
  }
}