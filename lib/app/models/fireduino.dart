class FireduinoModel {
  final int id;
  final String mac;
  final int estbID;
  final String name;
  final DateTime createdAt;

  FireduinoModel({
    required this.id,
    required this.mac,
    required this.estbID,
    required this.name,
    required this.createdAt,
  });

  factory FireduinoModel.fromJson(Map<String, dynamic> json) {
    return FireduinoModel(
      id: json['a'],
      mac: json['b'],
      estbID: json['c'],
      name: json['d'],
      createdAt: DateTime.parse(json['e']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'a': id,
      'b': mac,
      'c': estbID,
      'd': name,
      'e': createdAt.toIso8601String(),
    };
  }
}
