import 'package:e_commerce/core/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  YandexMapController? mapController;


  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    getLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.my_location),
      ),
      body: YandexMap(mapType: MapType.vector,
        rotateGesturesEnabled: false,
        nightModeEnabled: false,
        zoomGesturesEnabled: true,
        onMapCreated: (YandexMapController yandexMapController) async {
          mapController = yandexMapController;
          mapController!.moveCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                target: Point(latitude: 41.2995, longitude: 69.2401),
                zoom: 5,
              ),
            ),
          );
        },),
    );
  }
}
