import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product.dart';
import '../services/product_service.dart';
import '../controllers/cart_controller.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int jumlah = 1;

  late final CartController cartController;

  // Service untuk mengambil detail produk dari API
  final ProductService productService = ProductService();

  // Future untuk menyimpan proses pengambilan detail produk
  late Future<Product> productFuture;

  @override
  void initState() {
    super.initState();

    // Mengambil CartController dari GetX
    cartController = Get.find<CartController>();

    // Mengambil detail produk berdasarkan ID dari API
    productFuture = productService.fetchProductDetail(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),

      body: FutureBuilder<Product>(
        future: productFuture,
        builder: (context, snapshot) {
          // KONDISI LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // KONDISI ERROR
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60),

                  const SizedBox(height: 16),

                  const Text(
                    'Gagal memuat detail produk',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        productFuture = productService.fetchProductDetail(
                          widget.product.id,
                        );
                      });
                    },
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          // DATA TIDAK DITEMUKAN
          if (!snapshot.hasData) {
            return const Center(child: Text('Data produk tidak ditemukan'));
          }

          // DATA BERHASIL
          final product = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GAMBAR PRODUK
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.imageUrl,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 220,
                          width: double.infinity,
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 60,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // NAMA PRODUK
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // HARGA
                  Text(
                    'Rp ${product.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // KATEGORI
                  Row(
                    children: [
                      const Icon(Icons.category),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Kategori: ${product.category}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // STOK
                  Row(
                    children: [
                      const Icon(Icons.inventory_2),
                      const SizedBox(width: 8),
                      Text(
                        'Stok: ${product.stock}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // DESKRIPSI
                  const Text(
                    'Deskripsi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.description ?? 'Tidak ada deskripsi',
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),

                  const SizedBox(height: 24),

                  // JUMLAH
                  const Text(
                    'Jumlah',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  // TOMBOL JUMLAH
                  Row(
                    children: [
                      // Tombol kurang
                      IconButton(
                        onPressed: () {
                          if (jumlah > 1) {
                            setState(() {
                              jumlah--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove),
                      ),

                      // Tampilan jumlah
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$jumlah',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Tombol tambah
                      IconButton(
                        onPressed: () {
                          if (jumlah < product.stock) {
                            setState(() {
                              jumlah++;
                            });
                          }
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // TOMBOL TAMBAH KE KERANJANG
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: product.stock > 0
                          ? () {
                              // Menambahkan produk
                              // sebanyak jumlah yang dipilih
                              for (int i = 0; i < jumlah; i++) {
                                cartController.addToCart(product);
                              }

                              // Kembali ke halaman sebelumnya
                              Get.back();

                              // Menampilkan notifikasi
                              Get.snackbar(
                                'Berhasil',
                                '$jumlah ${product.name} '
                                    'ditambahkan ke keranjang',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.teal,
                                colorText: Colors.white,
                                margin: const EdgeInsets.all(10),
                                duration: const Duration(seconds: 3),
                              );
                            }
                          : null,
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Tambah ke Keranjang'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
