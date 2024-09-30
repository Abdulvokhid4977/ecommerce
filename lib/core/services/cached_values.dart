import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'location_service.dart';

class SearchHistoryManager {
  static const _keyLastSearchedString = 'last_searched_products';

  // Save a product search term
  static Future<void> saveSearchedProduct(String product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? searchedProducts =
        prefs.getStringList(_keyLastSearchedString) ?? [];
    searchedProducts.remove(product);
    searchedProducts.insert(0, product);
    if (searchedProducts.length > 3) {
      searchedProducts = searchedProducts.sublist(0, 3);
    }
    await prefs.setStringList(_keyLastSearchedString, searchedProducts);
  }

  static Future<void> deleteSearchString(String searchString) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> searchStrings =
        prefs.getStringList(_keyLastSearchedString) ?? [];
    searchStrings.remove(searchString);
    await prefs.setStringList(_keyLastSearchedString, searchStrings);
  }

  static Future<List<String>> getLastSearchedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyLastSearchedString) ?? [];
  }

  static Future<void> clearSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyLastSearchedString);
  }
}

class CurrentLocationManager {
  Future<void> saveLocationToSharedPreferences(Position position) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', position.latitude);
    await prefs.setDouble('longitude', position.longitude);
    if (kDebugMode) {
      print('Location saved to SharedPreferences');
    }
  }

  Future<Position?> getLocationFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final latitude = prefs.getDouble('latitude');
    final longitude = prefs.getDouble('longitude');

    if (latitude != null && longitude != null) {
      return Position(
        latitude: latitude,
        longitude: longitude,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
    }
    return null;
  }

// Example usage
  Future<void> handleLocation() async {
    try {
      Position position = await getLocation();
      await saveLocationToSharedPreferences(position);

      // Later, when you need to retrieve the location
      Position? savedPosition = await getLocationFromSharedPreferences();
      if (savedPosition != null) {
        if (kDebugMode) {
          print(
              'Retrieved location: ${savedPosition.latitude}, ${savedPosition.longitude}');
        }
      } else {
        if (kDebugMode) {
          print('No saved location found');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }
}

Future<void> saveCustomerId(String customerId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('customerId', customerId);
  if (kDebugMode) {print('CustomerId saved to SharedPreferences');}
}
Future<String?> getCustomerId() async {
final prefs = await SharedPreferences.getInstance();
return prefs.getString('customerId');
}
void deleteCustomerId() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
}


