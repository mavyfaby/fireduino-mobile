class FireduinoModel {
  final int id;
  final String serialId;
  final int estbID;
  final String name;
  final DateTime createdAt;

  FireduinoModel({
    required this.id,
    required this.serialId,
    required this.estbID,
    required this.name,
    required this.createdAt,
  });

  factory FireduinoModel.fromJson(Map<String, dynamic> json) {
    return FireduinoModel(
      id: json['a'],
      serialId: json['b'],
      estbID: json['c'],
      name: json['d'],
      createdAt: DateTime.parse(json['e']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'a': id,
      'b': serialId,
      'c': estbID,
      'd': name,
      'e': createdAt.toIso8601String(),
    };
  }
}
