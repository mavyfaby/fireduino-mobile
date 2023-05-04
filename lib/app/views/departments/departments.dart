import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/departments.dart';
import '../../models/department.dart';
import '../../env/config.dart';

class FireDepartmentsView extends StatelessWidget {
  const FireDepartmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {};

    final deptController = Get.find<FireDepartmentsController>();

    for (FireDepartmentModel dept in deptController.fireDepartments) {
      markers.add(
        Marker(
          markerId: MarkerId(dept.id.toString()),
          position: LatLng(dept.latitude, dept.longitude),          
          infoWindow: InfoWindow(
            title: dept.name,
            snippet: dept.address,
            onTap: () {
              showDeptInfo(dept); 
            }
          ),
        ),
      );
    }

    // Get the average latitude and longitude
    double x = 0;
    double y = 0;
    
    for (FireDepartmentModel dept in deptController.fireDepartments) {
      x += dept.latitude;
      y += dept.longitude;
    }

    x /= deptController.fireDepartments.length;
    y /= deptController.fireDepartments.length;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "${deptController.fireDepartments.length} fire departments listed.",
            style: Get.textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: GoogleMap(
                mapType: MapType.normal,
                indoorViewEnabled: true,
                compassEnabled: true,
                myLocationEnabled: true,
                markers: markers,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(defaultLatitude, defaultLongitude),
                  zoom: 13,
                ),
                onMapCreated: (GoogleMapController controller) {
                  // Get the current location of the user
                  Geolocator.getCurrentPosition().then((location) {
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(x, y),
                          zoom: 13,
                        ),
                      ),
                    );
                  });
                }
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Show the department information
  void showDeptInfo(FireDepartmentModel dept) {
    Get.dialog(AlertDialog(
      title: Text(dept.name),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text("Contact:", style: Get.textTheme.titleMedium),
              const SizedBox(width: 8),
              Text(dept.phone)
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Address:", style: Get.textTheme.titleMedium),
              const SizedBox(width: 8),
              Flexible(
                child: Text(dept.address)
              )
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Close"),
        ),
      ],
    ));
  }
}