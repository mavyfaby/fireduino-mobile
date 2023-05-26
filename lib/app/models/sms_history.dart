class SmsHistoryModel {
  final String deptName;
  final DateTime date;

  SmsHistoryModel({
    required this.deptName,
    required this.date
  });

  factory SmsHistoryModel.fromJson(Map<String, dynamic> json) {
    return SmsHistoryModel(
      deptName: json['name'],
      date: DateTime.parse(json['date_stamp'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': deptName,
      'date_stamp': date.toIso8601String()
    };
  }
}