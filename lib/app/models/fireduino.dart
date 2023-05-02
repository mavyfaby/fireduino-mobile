import './establishment.dart';

class FireduinoModel {
  final String serialId;
  final EstablishmentModel estb;

  FireduinoModel({
    required this.serialId,
    required this.estb,
  });

  factory FireduinoModel.fromJson(Map<String, dynamic> json) {
    return FireduinoModel(
      serialId: json['serialId'],
      estb: EstablishmentModel.fromJson(json['estb']),
    );
  }

  Map<String, dynamic> toJson() => {
    'serialId': serialId,
    'estb': estb.toJson(),
  };
}
