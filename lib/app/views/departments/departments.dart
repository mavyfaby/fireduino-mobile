import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/departments.dart';
import '../../controllers/main.dart';
import '../../models/department.dart';
import '../../env/config.dart';
import '../../models/establishment.dart';

class FireDepartmentsView extends StatelessWidget {
  const FireDepartmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {};

    final deptController = Get.find<FireDepartmentsController>();
    final mainController = Get.find<MainController>();
    final isReady = false.obs;

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

    markers.add(
      Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        markerId: MarkerId(mainController.estb.value.id.toString()),
        position: LatLng(double.parse(mainController.estb.value.latitude!), double.parse(mainController.estb.value.longitude!)),
        infoWindow: InfoWindow(
          title: mainController.estb.value.name,
          snippet: mainController.estb.value.address,
          onTap: () {
            showEstbInfo(mainController.estb.value); 
          }
        ),
      ),
    );    

    double x = 0;
    double y = 0;
    
    /// Calculate the centroid of the fire department coordinates
    for (FireDepartmentModel dept in deptController.fireDepartments) {
      x += dept.latitude;
      y += dept.longitude;
    }

    x /= deptController.fireDepartments.length;
    y /= deptController.fireDepartments.length;

    return Stack(
      children: [
        Obx(() => !isReady.value ? const Center(
          child: CircularProgressIndicator(),
        ) : const SizedBox()),
        GoogleMap(
          mapType: MapType.normal,
          indoorViewEnabled: true,
          compassEnabled: true,
          myLocationEnabled: true,
          markers: markers,
          initialCameraPosition: const CameraPosition(
            target: LatLng(defaultLatitude, defaultLongitude),
            zoom: 13,
          ),
          onMapCreated: (GoogleMapController controller) async {
            // Set {isReady} to true
            isReady.value = true;
            deptController.mapController = controller;

            // Get the current location of the user
            Geolocator.getCurrentPosition().then((location) {
              deptController.currentPosition = location;

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
      ],
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

  /// Show the establishment information
  void showEstbInfo(EstablishmentModel estb) {
    Get.dialog(AlertDialog(
      title: Text(estb.name!),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text("Contact:", style: Get.textTheme.titleMedium),
              const SizedBox(width: 8),
              Text(estb.phone!)
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
                child: Text(estb.address!)
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