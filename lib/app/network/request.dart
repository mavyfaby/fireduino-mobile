import 'dart:async';
import 'package:get/get.dart';

import '../models/fireduino.dart';
import '../store/global.dart';
import '../models/establishment.dart';
import '../models/user.dart';

import 'endpoints.dart';

// GetConnect instance
final _connect = GetConnect();

/// This class contains all the API calls for the app
class FireduinoAPI {
  // response data
  static dynamic component;
  static dynamic message;
  static dynamic data;

  /// Set data
  static void setData(Response response) {
    // If response.body is null
    if (response.body == null) {
      FireduinoAPI.component = 'error';
      FireduinoAPI.message = 'No response from server';
      FireduinoAPI.data = null;
      return;
    }

    FireduinoAPI.component = response.body['component'];
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

  /// Creates an account
  static Future<bool> createAccount(String firstName, String lastName, String email, String username, String password, String establishmentId, String inviteKey) async {
    try {
      // Declare form data
      final formData = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'username': username,
        'password': password,
        'establishmentId': establishmentId,
        'inviteKey': inviteKey,
      };

      /// Get the config from the server.
      Response response = await _connect.post(FireduinoEndpoints.user, formData, contentType: 'application/x-www-form-urlencoded');
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

  /// Logs in the user
  static Future<UserModel?> login(String username, String password) async {
    // Declare form data
    final formData = {
      'user': username,
      'pass': password,
    };

    try {
      // Request login
      Response response = await _connect.post(FireduinoEndpoints.login, formData, contentType: 'application/x-www-form-urlencoded');
      // Set data
      setData(response);

      // If the response is successful
      if (response.statusCode == 200) {
        // If not success
        if (!response.body['success']) return null;
        // Return status
        return UserModel.fromJson(response.body['data']);
      }

      return null;
    } on TimeoutException {
      return null;
    }
  }

  /// Validates the token
  static Future<bool> validateToken(String? token) async {
    // If token is null
    if (token == null) return false;

    try {
      // Request login with base64 encoded token
      Response response = await _connect.post(FireduinoEndpoints.validateToken, { 'token': token, }, contentType: 'application/x-www-form-urlencoded');
      // Set data
      setData(response);

      // If the response is successful
      if (response.statusCode == 200) {
        // If not success
        if (!response.body['success']) return false;
        // Return status
        return true;
      }

      return false;
    } on TimeoutException {
      return false;
    }
  }

  /// Gets the user by token
  static Future<UserModel?> getUserByToken(String? token) async {
    // If token is null
    if (token == null) return null;

    try {
      // Request login
      Response response = await _connect.get(FireduinoEndpoints.user, query: { 'token': token, }, contentType: 'application/x-www-form-urlencoded');
      // Set data
      setData(response);

      // If the response is successful
      if (response.statusCode == 200) {
        // If not success
        if (!response.body['success']) return null;
        // Return status
        return UserModel.fromJson(response.body['data']);
      }

      return null;
    } on TimeoutException {
      return null;
    }
  }

  /// Add fireduino
  static Future<bool> addFireduino(int estbID, String serialID, String name) async {
    try {
      // Declare form data
      final formData = {
        'estbID': estbID,
        'serialID': serialID,
        'name': name,
      };

      /// Get the config from the server.
      Response response = await _connect.post(FireduinoEndpoints.fireduino, formData,
        contentType: 'application/x-www-form-urlencoded',
        headers: {
          'Authorization': 'Bearer ${Global.token}',
        }
      );
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

  /// Fetches fireduinos from the server
  static Future<List<FireduinoModel>?> fetchFireduinos() async {
    try {
      /// Get the config from the server.
      Response response = await _connect.get(FireduinoEndpoints.fireduinos,
        query: { 'estbID': Global.user.eid?.toString() },
        headers: {
          'Authorization': 'Bearer ${Global.token}',
        },
        contentType: 'application/x-www-form-urlencoded'
      );
      // Set data
      setData(response);

      /// If the response is successful
      if (response.statusCode == 200) {
        // If not success
        if (!response.body['success']) {
          return null;
        }

        // Extract fireduinos
        final List<FireduinoModel> fireduinos = [];

        // For each fireduino
        for (final fireduino in response.body['message']) {
          // Add to list
          fireduinos.add(FireduinoModel.fromJson(fireduino));
        }

        // Return config
        return fireduinos;
      }

      return null;
    } on TimeoutException {
      return null;
    }
  }
}