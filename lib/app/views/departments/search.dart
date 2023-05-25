import 'package:fireduino/app/controllers/departments.dart';
import 'package:fireduino/app/network/request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../env/config.dart';

class SearchDepartments extends StatelessWidget {
  const SearchDepartments({super.key});

  @override
  Widget build(BuildContext context) {
    final deptController = Get.find<FireDepartmentsController>();

    return SearchAnchor(
      isFullScreen: true,
      builder: (context, controller) {
        return IconButton(
          onPressed: () {
            controller.openView();
          },
          icon: const Icon(Icons.search_outlined)
        );
      },

      suggestionsBuilder: (context, controller) {
        return [
          FutureBuilder(
            future: FireduinoAPI.fetchFireDepartments(
              search: controller.text,
              location: LatLng(
                deptController.currentPosition == null ? defaultLatitude : deptController.currentPosition!.latitude,
                deptController.currentPosition == null ? defaultLongitude : deptController.currentPosition!.longitude
              )
            ),
            builder:(context, snapshot) {
              // Check if snapshot is waiting
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              

              // If no data
              if (!snapshot.hasData) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularProgressIndicator()
                  ),
                );
              }

              // Check if establishments is empty
              if (snapshot.data!.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text("No fire departments found"),
                  ),
                );
              }

              // Sort by distance
              snapshot.data!.sort((a, b) => a.distanceValue!.compareTo(b.distanceValue!));

              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length + 1,
                itemBuilder: (context, index) {
                  if (index == snapshot.data!.length) {
                    return const ListTile();
                  }

                  return ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on_rounded),
                        Text(
                          snapshot.data![index].distance!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ]
                    ),
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].address, style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)
                    )),
                    onTap: () {
                      controller.closeView(controller.text);

                      if (deptController.mapController == null) {
                        return;
                      }

                      deptController.mapController!.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(snapshot.data![index].latitude, snapshot.data![index].longitude),
                            zoom: 17
                          ),
                        ),
                      );
                    },
                  );
                },
              ); 
            },
          )
        ];
      },
    );
  }
}