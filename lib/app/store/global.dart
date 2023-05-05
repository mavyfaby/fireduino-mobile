import 'package:device_info_plus/device_info_plus.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import 'store.dart';

class Global {
  static RxList<Map<String, dynamic>> onlineFireduinos = RxList.empty();

  static UserModel get user => UserModel.fromJson(Store.get(StoreKeys.user));
  static String? get token => Store.get(StoreKeys.loginToken);
  static String deviceId = "";

  static initDeviceInfo() async {
    // Get the device model
    deviceId = (await DeviceInfoPlugin().deviceInfo).data["model"];
    // Concatenate the device model with the device id
    deviceId = "$deviceId(${await PlatformDeviceId.getDeviceId})";
  }

  static List<String> months = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"
  ];

  static List<Map<String, dynamic>> get drawerItems => [
    {
      'title': 'Home',
      'route': '/home',
      'icon':  Icons.house_outlined,
      'sicon': Icons.house_rounded,
    },
    {
      'title': 'Fire Departments',
      'route': '/departments',
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
    }
  ];
}