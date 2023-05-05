import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../models/department.dart';

class FireDepartmentsController extends GetxController {
  Rx<Position?> currentPosition = null.obs;
  Rx<GoogleMapController?> mapController = null.obs;
  List<FireDepartmentModel> fireDepartments = <FireDepartmentModel>[].obs;
}