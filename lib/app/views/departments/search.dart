import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/main.dart';
import '../../network/request.dart';
import '../../env/config.dart';
import '../../controllers/departments.dart';

class SearchDepartments extends StatelessWidget {
  const SearchDepartments({super.key});

  @override
  Widget build(BuildContext context) {
    final deptController = Get.find<FireDepartmentsController>();
    final mainController = Get.find<MainController>();
    final searchController = SearchController();

    return SearchAnchor(
      isFullScreen: false,
      builder: (context, controller) {
        return IconButton(
          onPressed: () {
            controller.openView();
          },
          icon: const Icon(Icons.search_outlined)
        );
      },

      searchController: searchController,

      viewBuilder: (suggestions) {
        return FutureBuilder(
          future: FireduinoAPI.fetchFireDepartments(
            search: searchController.text,
            location: LatLng(
              mainController.estb.value.id == null ? defaultLatitude : double.parse(mainController.estb.value.latitude!),
              mainController.estb.value.id == null ? defaultLongitude : double.parse(mainController.estb.value.longitude!)
            )
          ),
          builder:(context, snapshot) {
            debugPrint(snapshot.data.toString());

            // Check if snapshot is waiting
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // Check if has no data
            if (!snapshot.hasData) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Center(
                  child: Text("No data found"),
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
            snapshot.data!.sort((a, b) => a.distance!.compareTo(b.distance!));

            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(
                    width: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on_rounded),
                        const SizedBox(height: 3),
                        Text(
                          "${snapshot.data![index].distance!.toStringAsPrecision(2)} km",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ]
                    ),
                  ),
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(snapshot.data![index].address, style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7)
                  )),
                  onTap: () {
                    searchController.closeView(searchController.text);
            
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
        );
      },

      suggestionsBuilder: (context, controller) {
        return [
          
        ];
      },
    );
  }
}