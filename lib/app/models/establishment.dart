class EstablishmentModel {
  final int? id;
  final String? name;
  final String? address;
  final String? phone;
  final String? email;
  final String? inviteKey;
  final String? createdAt;

  EstablishmentModel({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.inviteKey,
    this.createdAt,
  });

  factory EstablishmentModel.fromJson(Map<String, dynamic> json) {
    return EstablishmentModel(
      id: json['a'],
      inviteKey: json['b'],
      name: json['c'],
      address: json['e'],
      phone: json['d'],
      createdAt: json['f'],
      // email: json['email'],
    );
  }
}