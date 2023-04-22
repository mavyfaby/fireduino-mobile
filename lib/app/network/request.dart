import 'dart:async';

import 'package:fireduino/app/models/establishment.dart';
import 'package:fireduino/app/network/endpoints.dart';
import 'package:get/get.dart';

// GetConnect instance
final _connect = GetConnect();

/// This class contains all the API calls for the app
class FireduinoAPI {
  // response data
  static dynamic message;
  static dynamic data;

  /// Set data
  static void setData(Response response) {
    FireduinoAPI.message = response.body['message'];
    FireduinoAPI.data = response.body['data'];
  }

  /// Fetches establishments from the server
  static Future<List<EstablishmentModel>?> fetchEstablishments(String? name) async {
    try {
      // Declare form data
      Map<String, dynamic> query = {};

      // If name is not null
      if (name != null) {
        // Add name to form data
        query = {
          'search': name,
          'nameOnly': '1',
        };
      }

      /// Get the config from the server.
      Response response = await _connect.get(FireduinoEndpoints.establishments, query: query);
      // Set data
      setData(response);

      /// If the response is successful
      if (response.statusCode == 200) {

        // If not success
        if (!response.body['success']) {
          return null;
        }

        // Extract establishments
        final List<EstablishmentModel> establishments = [];

        // For each establishment
        for (final establishment in response.body['data']) {
          // Add to list
          establishments.add(EstablishmentModel.fromJson(establishment));
        }

        // Return config
        return establishments;
      }

      return null;
    } on TimeoutException {
      return null;
    }
  }

  /// Verifies the invite key
  static Future<bool> verifyInviteKey(String establishmentId, String inviteKey) async {
    try {
      // Declare form data
      final formData = {
        'id': establishmentId,
        'inviteKey': inviteKey,
      };

      /// Get the config from the server.
      Response response = await _connect.post(FireduinoEndpoints.verifyKey, formData, contentType: 'application/x-www-form-urlencoded');
      // Set data
      setData(response);

      /// If the response is successful
      if (response.statusCode == 200) {
        // Return status
        return response.body['success'];
      }

      return false;
    } on TimeoutException {
      return false;
    }
  }
}