import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/edit_history.dart';
import '../models/incident.dart';
import '../network/socket.dart';
import '../models/dashboard.dart';
import '../models/department.dart';
import '../models/fireduino.dart';
import '../store/global.dart';
import '../models/establishment.dart';
import '../models/user.dart';

import '../utils/date.dart';
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
  static Future<bool> addFireduino(int estbID, String socketId, String mac, String name) async {
    try {
      // Declare form data
      final formData = {
        'estbID': estbID,
        'mac': mac,
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
        bool success = response.body['success'];

        // If success
        if (success) {
          // Emit fireduino add to socket
          FireduinoSocket.instance.addFireduino(socketId, estbID);
        }
  
        return success;
      }

      return false;
    } on TimeoutException {
      return false;
    }
  }

  /// Edit fireduino
  static Future<bool> editFireduino(int estbID, int deviceId, String mac, String name) async {
    try {
      // Declare form data
      final formData = {
        'estbID': estbID,
        'deviceID': deviceId,
        'mac': mac,
        'name': name,
      };

      /// Get the config from the server.
      Response response = await _connect.put(FireduinoEndpoints.fireduino, formData,
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
        for (final fireduino in response.body['data']) {
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

  /// Fetches fire departments from the server
  static Future<List<FireDepartmentModel>> fetchFireDepartments({ String? search, LatLng? location }) async {
    try {
      /// Get the config from the server.
      Response response = await _connect.get(FireduinoEndpoints.departments,
        query: location != null ? {
          'search': search ?? '',
          'location': '${location.latitude},${location.longitude}',
        } : null,
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
          return [];
        }

        // Extract fire departments
        final List<FireDepartmentModel> fireDepartments = [];

        // For each fire department
        for (final fireDepartment in response.body['data']) {
          // Add to list
          fireDepartments.add(FireDepartmentModel.fromJson(fireDepartment));
        }

        // Return config
        return fireDepartments;
      }

      return [];
    } on TimeoutException {
      return [];
    }
  }

  /// Fetches dashboard data from the server
  static Future<DashboardDataModel?> fetchDashboardData(int year, bool isQuarter12) async {
    try {
      /// Get the config from the server.
      Response response = await _connect.get(FireduinoEndpoints.dashboard,
        query: {
          'year': '$year', 'isQuarter12': isQuarter12 ? '1' : '0'
        },
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

        // Return config
        return DashboardDataModel.fromJson(response.body['data']);
      }

      return null;
    } on TimeoutException {
      return null;
    }
  }

  /// Determine whether the email exists
  static Future<bool> isEmailExist(String email) async {
    try {
      // Declare form data
      final formData = {
        'email': email,
      };

      /// Get the config from the server.
      Response response = await _connect.post(FireduinoEndpoints.validateEmail, formData,
        contentType: 'application/x-www-form-urlencoded'
      );
      // Set data
      setData(response);

      /// If the response is successful
      if (response.statusCode == 200) {
        // If not success
        return response.body['success'] && response.body['data'];
      }

      return false;
    } on TimeoutException {
      return false;
    }
  }

  /// Update user
  static Future<bool> updateUser(int type, String value) async {
    // Declare form data
    final formData = {
      'token': Global.token,
      'type': type,
      'value': value,
    };

    try {
      /// Update user
      Response response = await _connect.put(FireduinoEndpoints.user, formData, contentType: 'application/x-www-form-urlencoded',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
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

  /// Fetch login history
  static Future<List<List<String>>?> fetchLoginHistory() async {
    try {
      /// Get the config from the server.
      Response response = await _connect.get(FireduinoEndpoints.loginHistory,
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

        // Extract login history
        final List<List<String>> loginHistory = [];

        // For each login history
        for (final history in response.body['data']) {
          // Get date stasmp
          final date = DateTime.parse(history['date_stamp']);
          // Add to list
          loginHistory.add([ getDate(date), getTime(date) ]);
        }

        // Return config
        return loginHistory;
      }

      return null;
    } on TimeoutException {
      return null;
    }
  }

  /// Fetch access logs
  static Future<List<List<String>>?> fetchAccessLogs() async {
    try {
      /// Get the config from the server.
      Response response = await _connect.get(FireduinoEndpoints.accessLogs,
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

        // Extract access logs
        final List<List<String>> accessLogs = [];

        // For each access log
        for (final accessLog in response.body['data']) {
          // Add to list
          accessLogs.add([ accessLog['name'], getReadableDate(DateTime.parse(accessLog['date_stamp'])) ]);
        }

        // Return config
        return accessLogs;
      }

      return null;
    } on TimeoutException {
      return null;
    }
  }

  /// Get incident reports
  static Future<List<IncidentReport>?> fetchIncidentReports() async {
    try {
      /// Get the config from the server.
      Response response = await _connect.get(FireduinoEndpoints.incidentReports,
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

        // Extract incident reports
        final List<IncidentReport> incidentReports = [];

        // For each incident report
        for (final incidentReport in response.body['data']) {
          // Add to list
          incidentReports.add(IncidentReport.fromJson(incidentReport));
        }

        // Return config
        return incidentReports;
      }

      return null;
    } on TimeoutException {
      return null;
    }
  }

  /// Add access log
  static Future<bool> addAccessLog(int id) async {
    // Declare form data
    final formData = {
      'id': id,
    };

    try {
      /// Add access log
      Response response = await _connect.post(FireduinoEndpoints.access, formData,
        headers: {
          'Authorization': 'Bearer ${Global.token}',
        },
        contentType: 'application/x-www-form-urlencoded'
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

  /// Add incident report
  static Future<bool> addIncidentReport(int id, String report) async {
    // Convert report to base64
    final reportBase64 = base64Encode(utf8.encode(report));

    try {
      /// Add incident report
      Response response = await _connect.post(FireduinoEndpoints.incidentReport, {
        'incidentID': id,
        'report': reportBase64,
      },
        headers: {
          'Authorization': 'Bearer ${Global.token}',
        },
        contentType: 'application/x-www-form-urlencoded'
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

  /// Edit incident report
  static Future<bool> editIncidentReport(int incidentID, int reportID, String report) async {
    // Convert report to base64
    final reportBase64 = base64Encode(utf8.encode(report));

    try {
      /// Add incident report
      Response response = await _connect.put(FireduinoEndpoints.incidentReport, {
        'incidentID': incidentID,
        'reportID': reportID,
        'report': reportBase64,
      },
        headers: {
          'Authorization': 'Bearer ${Global.token}',
        },
        contentType: 'application/x-www-form-urlencoded'
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

  /// Fetch all edit history
  static Future<List<EditHistoryModel>?> fetchEditHistory() async {
    try {
      /// Get the config from the server.
      Response response = await _connect.get(FireduinoEndpoints.editHistory,
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

        // Extract edit history
        final List<EditHistoryModel> editHistory = [];

        // For each edit history
        for (final history in response.body['data']) {
          // Add to list
          editHistory.add(EditHistoryModel.fromJson(history));
        }

        // Return edit history
        return editHistory;
      }

      return null;
    } on TimeoutException {
      return null;
    }
  }
}