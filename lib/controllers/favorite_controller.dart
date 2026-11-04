import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteController extends GetxController {
  final RxSet<String> favoriteIds = <String>{}.obs;

  static const String _key = 'wishlist';

  // Memuat wishlist dari SharedPreferences
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final savedIds = prefs.getStringList(_key) ?? [];

    favoriteIds.assignAll(savedIds);
  }

  // Memeriksa apakah produk termasuk favorit
  bool isFavorite(int productId) {
    return favoriteIds.contains(productId.toString());
  }

  // Menambah atau menghapus favorit
  Future<void> toggleFavorite(int productId) async {
    final id = productId.toString();

    if (favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_key, favoriteIds.toList());
  }

  // Menghapus produk dari wishlist
  Future<void> removeFavorite(int productId) async {
    favoriteIds.remove(productId.toString());

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_key, favoriteIds.toList());
  }
}
