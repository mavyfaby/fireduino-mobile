import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../models/department.dart';

class FireDepartmentsController extends GetxController {
  RxList<FireDepartmentModel> fireDepartments = <FireDepartmentModel>[].obs;
  Rx<GoogleMapController?> mapController = null.obs;
  Rx<Position?> currentPosition = null.obs;
}