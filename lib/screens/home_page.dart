import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_card.dart';
import '../services/product_service.dart';

import 'package:get/get.dart';

import 'product_detail_page.dart';

import '../controllers/cart_controller.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onOpenCart;

  const HomePage({super.key, required this.onOpenCart});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CartController cartController = Get.find<CartController>();

  final ProductService productService = ProductService();

  late Future<List<Product>> productsFuture;

  @override
  void initState() {
    super.initState();

    productsFuture = productService.fetchProducts();
  }

  // FUNGSI LOAD PRODUK

  void loadProducts() {
    setState(() {
      productsFuture = productService.fetchProducts();
    });
  }

  // FUNGSI PULL-TO-REFRESH
  Future<void> refreshProducts() async {
    final future = productService.fetchProducts();

    setState(() {
      productsFuture = future;
    });

    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TokoKita')),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TokoKita',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Belanja jadi lebih mudah',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),

                // TOMBOL KERANJANG
                Obx(() {
                  final jumlah = cartController.totalItem;

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        onPressed: widget.onOpenCart,
                        icon: const Icon(Icons.shopping_cart_outlined),
                      ),

                      if (jumlah > 0)
                        Positioned(
                          right: 2,
                          top: 2,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$jumlah',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ],
            ),

            const SizedBox(height: 16),

            // DATA PRODUK DARI API
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: productsFuture,
                builder: (context, snapshot) {
                  // LOADING

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // ERROR
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Gagal memuat produk, coba lagi',
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 16),

                          ElevatedButton(
                            onPressed: loadProducts,
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    );
                  }

                  // BERHASIL
                  final products = snapshot.data ?? [];

                  if (products.isEmpty) {
                    return const Center(child: Text('Tidak ada produk'));
                  }

                  // PULL-TO-REFRESH
                  return RefreshIndicator(
                    onRefresh: refreshProducts,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),

                      itemCount: products.length,

                      itemBuilder: (context, index) {
                        final product = products[index];

                        return ProductCard(
                          product: product,

                          onTap: () {
                            Get.to(() => ProductDetailPage(product: product));
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
