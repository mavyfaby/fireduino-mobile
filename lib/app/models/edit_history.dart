class EditHistoryModel {
  final String name;
  final String before;
  final String after;
  final DateTime date;

  EditHistoryModel({
    required this.name,
    required this.before,
    required this.after,
    required this.date
  });

  factory EditHistoryModel.fromJson(Map<String, dynamic> json) {
    return EditHistoryModel(
      name: json['name'],
      before: json['before'],
      after: json['after'],
      date: DateTime.parse(json['date_stamp'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'before': before,
      'after': after,
      'date_stamp': date.toIso8601String()
    };
  }
}