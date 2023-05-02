class EstablishmentModel {
  final int? id;
  final String? name;
  final String? address;
  final String? latitude;
  final String? longitude;
  final String? phone;
  final String? inviteKey;
  final String? createdAt;

  EstablishmentModel({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.phone,
    this.inviteKey,
    this.createdAt,
  });

  factory EstablishmentModel.fromJson(Map<String, dynamic> json) {
    return EstablishmentModel(
      id: json['a'],
      inviteKey: json['b'],
      name: json['c'],
      phone: json['d'],
      address: json['e'],
      latitude: json['f'],
      longitude: json['g'],
      createdAt: json['h'],
    );
  }

  Map<String, dynamic> toJson() => {
    'a': id,
    'b': inviteKey,
    'c': name,
    'd': phone,
    'e': address,
    'f': latitude,
    'g': longitude,
    'h': createdAt,
  };
}