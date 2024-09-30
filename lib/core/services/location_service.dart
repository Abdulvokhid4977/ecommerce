import 'package:e_commerce/core/services/cached_values.dart';
import 'package:e_commerce/data/models/location_model.dart';
import 'package:e_commerce/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';

Future<void> requestLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      if (kDebugMode) {
        print("Location permission denied}");
      }

      return;
    }
  }
  if (kDebugMode) {
    print("Location permission granted.");
  }
}

Future<Position> getLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled');
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied');
  }
  Position position = await Geolocator.getCurrentPosition();
  await CurrentLocationManager().saveLocationToSharedPreferences(position);
  return position;
}

class LocationService {
  static final Box<LocationElement> _box = getIt<Box<LocationElement>>();

  Future<void> addToCart(LocationElement location) async {
    final existingItem = _box.get(location.id);
    if (existingItem != null) {
      await updateProductQuantity(location);
    } else {
      await _box.put(location.id, location);
    }
  }

  Future<List<LocationElement>> getCartProducts() async {
    return _box.values.toList();
  }

  Future<void> updateProductQuantity(LocationElement location) async {
    await _box.put(location.id, location);
  }

  Future<void> removeFromCart(List<String> productIds) async {
    await _box.deleteAll(productIds);
  }

  Future<void> clearLocation() async {
    await _box.clear();
  }

  LocationElement? getCartItem(String productId) {
    return _box.get(productId);
  }

  Future<LocationWithDetails?> findNearestLocation() async {
    try {
      Position currentPosition = await getLocation();
      List<LocationElement> locations = await getCartProducts();

      if (locations.isEmpty) return null;

      LocationElement nearestLocation = locations[0];
      double nearestDistance = double.infinity;

      for (var location in locations) {
        double distance = Geolocator.distanceBetween(
          currentPosition.latitude,
          currentPosition.longitude,
          location.latitude,
          location.longitude,
        );

        if (distance < nearestDistance) {
          nearestDistance = distance;
          nearestLocation = location;
        }
      }

      List<Placemark> placeMark = await placemarkFromCoordinates(
        nearestLocation.latitude,
        nearestLocation.longitude,
      );

      String address = "Address not found";
      if (placeMark.isNotEmpty) {
        Placemark place = placeMark[0];
        address = "${place.street}, ${place.locality}, ${place.country}";
      }

      return LocationWithDetails(
        location: nearestLocation,
        address: address,
        name: nearestLocation.name,
        info: nearestLocation.info,
        image: nearestLocation.image,
        opensAt: nearestLocation.opensAt,
        closesAt: nearestLocation.closesAt,
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error finding nearest location: $e");
      }
      return null;
    }
  }

  Future<String> getAddressFromLatLong(
      double latitude, double longitude) async {
    try {
      // Get placemarks from latitude and longitude
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(latitude, longitude);

      // If there are placemarks, return the first one’s address
      if (placeMarks.isNotEmpty) {
        Placemark place = placeMarks.first;

        return '${place.street}, ${place.locality}, ${place.country}';
      } else {
        return 'No address found';
      }
    } catch (e) {
      // Handle any exceptions
      return 'Error retrieving address: $e';
    }
  }
}

class LocationWithDetails {
  LocationElement location;
  String address;
  String name;
  String info;
  String image;
  String? opensAt;
  String? closesAt;
  // Add any other fields you want to include

  LocationWithDetails({
    required this.location,
    required this.address,
    required this.name,
    required this.info,
    required this.image,
    required this.opensAt,
    required this.closesAt,
    // Add any other fields in the constructor
  });
}
