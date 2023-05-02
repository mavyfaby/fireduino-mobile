import 'dart:async';

import 'package:get/get.dart';

import '../models/user.dart';
import '../network/request.dart';

import 'store.dart';

class FireduinoAuth {
  static final isAuthenticated = false.obs;
  static final isRevoked = false.obs;

  /// Initialize the global store
  static Future<void> init() async {
    // Get token
    String? token = Store.get(StoreKeys.loginToken);
    // Check if the user is logged in
    isAuthenticated.value = await FireduinoAPI.validateToken(token);

    // If the user authenticated
    if (isAuthenticated.value) {
      // refresh user by getting the user from the server by token
      UserModel? user = await FireduinoAPI.getUserByToken(token);

      // If the user is not null
      if (user != null) {
        // Set the user
        Store.set(StoreKeys.user, user.toJson());
        return;
      }

      // If the user is null, set isAuthenticated to false
      isAuthenticated.value = false;
      // Set {isRevoked} to true
      isRevoked.value = true;
    }
  }
}