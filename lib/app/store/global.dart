import 'package:device_info_plus/device_info_plus.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import 'store.dart';

class Global {
  static User get user => User.fromJson(Store.get(StoreKeys.user));
  static String deviceId = "";

  static initDeviceInfo() async {
    // Get the device model
    deviceId = (await DeviceInfoPlugin().deviceInfo).data["model"];
    // Concatenate the device model with the device id
    deviceId = "$deviceId(${await PlatformDeviceId.getDeviceId})";
  }

  static List<Map<String, dynamic>> get drawerItems => [
    {
      'title': 'Fire Departments',
      'route': '/fire-departments',
      'icon':  Icons.fire_truck_outlined,
      'sicon': Icons.fire_truck_rounded,
    },
    {
      'title': 'Incident Reports',
      'route': '/incident-reports',
      'icon':  Icons.report_outlined,
      'sicon': Icons.report,
    },
    {
      'title': 'Access Logs',
      'route': '/access-logs',
      'icon':  Icons.access_time_outlined,
      'sicon': Icons.access_time,
    },
    {
      'title': 'Edit History',
      'route': '/edit-history',
      'icon':  Icons.history_outlined,
      'sicon': Icons.history,
    },
    {
      'title': 'Login History',
      'route': '/login-history',
      'icon':  Icons.work_history_outlined,
      'sicon': Icons.work_history_rounded,
    },
    {
      'title': 'SMS History',
      'route': '/sms-history',
      'icon':  Icons.sms_outlined,
      'sicon': Icons.sms,
    },
  ];
}