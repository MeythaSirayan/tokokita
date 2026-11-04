import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/favorite_controller.dart';
import '../services/product_service.dart';
import '../models/product.dart';

class WishlistPage extends StatelessWidget {
  WishlistPage({super.key});

  final FavoriteController favoriteController = Get.find<FavoriteController>();

  final ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist Saya')),
      body: FutureBuilder<List<Product>>(
        future: productService.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Gagal memuat produk'));
          }

          final products = snapshot.data ?? [];

          return Obx(() {
            final favoriteProducts = products
                .where((product) => favoriteController.isFavorite(product.id))
                .toList();

            if (favoriteProducts.isEmpty) {
              return const Center(
                child: Text(
                  'Wishlist masih kosong',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Image.network(
                      product.imageUrl,
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stack) {
                        return const Icon(Icons.image);
                      },
                    ),
                    title: Text(product.name),
                    subtitle: Text('Rp ${product.price.toStringAsFixed(0)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await favoriteController.removeFavorite(product.id);
                      },
                    ),
                  ),
                );
              },
            );
          });
        },
      ),
    );
  }
}
