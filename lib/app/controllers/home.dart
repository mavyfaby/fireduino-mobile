import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final pageController = PageController();
  final pageIndex = 0.obs;

  // MAC address and name of the fireduino device in the Add Fireduino view
  final TextEditingController mac = TextEditingController();
  final TextEditingController name = TextEditingController();
}