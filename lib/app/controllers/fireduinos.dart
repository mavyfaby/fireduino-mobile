import 'package:get/get.dart';

import '../utils/dialog.dart';
import '../models/fireduino.dart';
import '../network/request.dart';

class FireduinosController extends GetxController {
  final RxList<FireduinoModel> devices = <FireduinoModel>[].obs;
  
  int get count => devices.length;

  Future<void> fetchFireduinos() async {
    List<FireduinoModel>? devices = await FireduinoAPI.fetchFireduinos();

    if (devices == null) {
      showAppDialog("Error", FireduinoAPI.message);
      return;
    }

    // isFetching.value = false;
    this.devices.value = devices;
  }
}