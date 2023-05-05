import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../env/config.dart';

class FireduinoStatus extends StatelessWidget {
  const FireduinoStatus({ required this.isOnline, super.key});

  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    final Color color = isOnline ? 
      Get.theme.brightness == Brightness.light ?
        Colors.teal.shade600 :
        Colors.teal.shade300 :
      Get.theme.brightness == Brightness.light ?
        Colors.red.shade600 :
        Colors.red.shade300;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        const SizedBox(width: 8),
        Text("Device is o${isOnline ? "n" : "ff"}line", style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w500,
          fontFamily: appDefaultFont,
          color: color
        )),
      ],
    );
  }
}