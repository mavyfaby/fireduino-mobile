import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/dialog.dart';
import '../store/auth.dart';
import '../store/store.dart';

/// Middleware to check if the user is logged in
class SessionMiddleware extends GetMiddleware {
  @override // page called
  GetPage? onPageCalled(GetPage? page) {
    // If page is login and the token is revoked, show an error dialog
    if (page?.name == "/home" && FireduinoAuth.isRevoked.value) {
      // Show an error dialog
      Timer.run(() {
        showAppDialog("Session Error", "An error occured while validating your session. Please login again.");
      });
    }

    return page;
  }
  

  @override
  RouteSettings? redirect(String? route) {
    // If the user is not logged in, redirect to the login page
    if (!FireduinoAuth.isAuthenticated.value) {
      // If the token is revoked, show an error dialog
      if (FireduinoAuth.isRevoked.value) {
        // Remove token
        Store.remove(StoreKeys.loginToken);
      }

      // Redirect to the login page
      return const RouteSettings(name: "/login");
    }

    // If the user is logged in, allow the route
    return null;
  }
}