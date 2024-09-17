import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryManager {
  static const _keyLastSearchedString = 'last_searched_products';

  // Save a product search term
  static Future<void> saveSearchedProduct(String product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? searchedProducts =
        prefs.getStringList(_keyLastSearchedString) ?? [];

    // If the product already exists, remove it so it can be added to the front of the list
    searchedProducts.remove(product);

    // Add the new product to the front of the list
    searchedProducts.insert(0, product);

    // Keep only the last 3 searches
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
