import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/cached_values.dart';
import 'package:e_commerce/core/services/location_service.dart';
import 'package:e_commerce/core/utils/utils.dart';
import 'package:e_commerce/data/models/location_model.dart';
import 'package:e_commerce/presentation/bloc/location/location_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget {
  final bool showModalOnTap;
  final void Function(Point, String, String, String, String)? onMarkerChosen;

  const MapPage({super.key, required this.showModalOnTap, this.onMarkerChosen});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LocationService _locationService = GetIt.I<LocationService>();
  YandexMapController? _mapController;
  final List<MapObject> _mapObjects = [];
  Position? _position;
  List<LocationElement> _locations = [];
  PlacemarkMapObject? _userLocationMarker;
  String? newAddress;
  String? name;
  String? opensAt;
  String? closesAt;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  bool isStoreOpen(String openingTime, String closingTime) {
    DateTime now = DateTime.now();
    DateFormat timeFormat = DateFormat("HH:mm");
    DateTime openingDateTime = timeFormat.parse(openingTime);
    DateTime closingDateTime = timeFormat.parse(closingTime);
    openingDateTime = DateTime(now.year, now.month, now.day,
        openingDateTime.hour, openingDateTime.minute);
    closingDateTime = DateTime(now.year, now.month, now.day,
        closingDateTime.hour, closingDateTime.minute);
    if (now.isAfter(openingDateTime) && now.isBefore(closingDateTime)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _initializeMap() async {
    await _retrievePosition();
    await _retrieveLocations();
  }

  Future<void> _retrievePosition() async {
    _position =
        await CurrentLocationManager().getLocationFromSharedPreferences();
    if (_position != null) {
      _addUserMarker(_position!);
    } else {
      if (kDebugMode) {
        print("Retrieved position is null");
      }
    }
  }

  Future<void> _retrieveLocations() async {
    _locations = await _locationService.getCartProducts();
    _addLocationMarkers();
  }

  Future<void> _openInMaps(double latitude, double longitude) async {
    final url = 'geo:$latitude,$longitude';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open the map.')),
      );
    }
  }

  void _addUserMarker(Position position) {
    _userLocationMarker = PlacemarkMapObject(
      mapId: const MapObjectId('user_location'),
      point: Point(latitude: position.latitude, longitude: position.longitude),
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
        image: BitmapDescriptor.fromAssetImage('assets/images/location.png'),
        scale: 0.2,
      )),
      opacity: 1.0,
    );
    setState(() {
      _mapObjects.add(_userLocationMarker!);
    });
  }

  void _addLocationMarkers() {
    for (var location in _locations) {
      final marker = PlacemarkMapObject(
        mapId: MapObjectId('location_${location.id}'),
        point:
            Point(latitude: location.latitude, longitude: location.longitude),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image:
              BitmapDescriptor.fromAssetImage('assets/images/headquarter.jpg'),
          scale: 0.2,
        )),
        opacity: 1,
        onTap: (PlacemarkMapObject self, Point point) {
          _showBottomSheet(location);
        },
      );
      setState(() {
        _mapObjects.add(marker);
      });
    }
  }

  void _showBottomSheet(LocationElement location) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  location.name,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SelectableText(
                  '${location.latitude}, ${location.longitude}',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w300,
                    fontSize: 10,
                  ),
                ),
                AppUtils.kHeight8,
                Row(
                  children: [
                    SelectableText(
                      '${location.opensAt} - ${location.closesAt}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                    AppUtils.kWidth8,
                    SelectableText(
                      isStoreOpen(location.opensAt!, location.closesAt!)
                          ? "Открыто"
                          : "Закрыто",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color:
                            isStoreOpen(location.opensAt!, location.closesAt!)
                                ? Colours.greenIndicator
                                : Colours.redCustom,
                      ),
                    ),
                  ],
                ),
                SelectableText(
                  location.info,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                  ),
                ),
                AppUtils.kHeight16,
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colours.textFieldGrey),
                  height: 250,
                  width: SizeConfig.screenWidth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      location.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                AppUtils.kHeight16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Open in Maps Button
                    ElevatedButton(
                      onPressed: () =>
                          _openInMaps(location.latitude, location.longitude),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                            widget.onMarkerChosen != null
                                ? 150
                                : SizeConfig.screenWidth! - 32,
                            50),
                      ),
                      child: const Text('Open in Maps'),
                    ),

                    if (widget.onMarkerChosen != null)
                      ElevatedButton(
                        onPressed: () async {
                          final address =
                              await LocationService().getAddressFromLatLong(
                            location.latitude,
                            location.longitude,
                          );
                          newAddress = address;
                          name = location.name;
                          opensAt = location.opensAt;
                          closesAt = location.closesAt;
                          widget.onMarkerChosen?.call(
                              Point(
                                latitude: location.latitude,
                                longitude: location.longitude,
                              ),
                              newAddress!,
                              name!,
                              opensAt!,
                              closesAt!);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 50),
                        ),
                        child: const Text('Choose this Marker'),
                      ),
                  ],
                ),
                // ElevatedButton(
                //   onPressed: () =>
                //       _openInMaps(location.latitude, location.longitude),
                //   style: ElevatedButton.styleFrom(
                //     minimumSize: const Size(double.infinity, 50),
                //   ),
                //   child: const Text('Open in Maps'),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _moveToUserLocation() {
    if (_position != null && _mapController != null) {
      _mapController!.moveCamera(
        animation:
            const MapAnimation(type: MapAnimationType.smooth, duration: 1.0),
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
                latitude: _position!.latitude, longitude: _position!.longitude),
            zoom: 15,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          splashRadius: 24,
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_outlined,
              color: Colours.blueCustom, size: 24),
        ),
        title: Text(
          'Пункт выдачи на карте',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w400, fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _moveToUserLocation,
        child: const Icon(Icons.my_location),
      ),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading || _position == null) {
            return Center(
                child: Lottie.asset("assets/lottie/loading.json",
                    height: 140, width: 140));
          } else if (state is LocationFetched) {
            return YandexMap(
              mapType: MapType.vector,
              mapObjects: _mapObjects,
              rotateGesturesEnabled: true,
              nightModeEnabled: false,
              zoomGesturesEnabled: true,
              onMapCreated: (YandexMapController controller) {
                _mapController = controller;
                _moveToUserLocation();
              },
            );
          } else if (state is LocationError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Something is wrong'));
          }
        },
      ),
    );
  }
}
