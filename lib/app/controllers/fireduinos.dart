import 'package:fireduino/app/models/fireduino.dart';
import 'package:get/get.dart';

import '../network/request.dart';

class FireduinosController extends GetxController {
  final RxList<FireduinoModel> devices = <FireduinoModel>[].obs;
  
  int get count => devices.length;

  Future<void> fetchFireduinos() async {
    List<FireduinoModel>? devices = await FireduinoAPI.fetchFireduinos();

    if (devices == null) {
      return;
    }

    this.devices.value = devices;
  }
}