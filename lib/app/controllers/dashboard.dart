import 'package:get/get.dart';

class DashController extends GetxController {
  final RxInt fireduinos = (10).obs;
  final RxInt departments= (11).obs;

  final RxInt year = DateTime.now().year.obs;
  final RxBool isQuarter12 = true.obs;
  
  final List<int> data = [
    0, 1, 4, 1, 0, 0
  ];

  Future<void> fetchDashboardData() async {

  }
}