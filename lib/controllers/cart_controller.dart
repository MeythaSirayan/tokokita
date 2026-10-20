import 'package:get/get.dart';

import '../models/product.dart';

class CartController extends GetxController {
  final RxList<Product> items = <Product>[].obs;

  // Jumlah setiap produk, berdasarkan ID produk.
  final RxMap<String, int> quantities = <String, int>{}.obs;

  int quantityOf(Product product) {
    return quantities[product.id.toString()] ?? 1;
  }

  int get totalItem => quantities.values.fold(0, (sum, qty) => sum + qty);

  double get totalHarga {
    double total = 0;

    for (final product in items) {
      total += product.price * quantityOf(product);
    }

    return total;
  }

  void addToCart(Product product) {
    final index = items.indexWhere((item) => item.id == product.id);

    final key = product.id.toString();

    if (index >= 0) {
      quantities[key] = quantityOf(product) + 1;
    } else {
      items.add(product);
      quantities[key] = 1;
    }

    quantities.refresh();
  }

  void removeFromCart(Product product) {
    items.removeWhere((item) => item.id == product.id);
    quantities.remove(product.id.toString());
    quantities.refresh();
  }

  void increaseQuantity(Product product) {
    final key = product.id.toString();
    quantities[key] = quantityOf(product) + 1;
    quantities.refresh();
  }

  void decreaseQuantity(Product product) {
    if (quantityOf(product) <= 1) return;

    final key = product.id.toString();
    quantities[key] = quantityOf(product) - 1;
    quantities.refresh();
  }

  void clearCart() {
    items.clear();
    quantities.clear();
    quantities.refresh();
  }
}
