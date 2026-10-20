import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import 'checkout_success_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Kosongkan keranjang',
            onPressed: () {
              if (controller.items.isEmpty) return;

              Get.dialog(
                AlertDialog(
                  title: const Text('Kosongkan keranjang?'),
                  content: const Text(
                    'Semua produk akan dihapus dari keranjang.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Batal'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.clearCart();
                        Get.back();
                      },
                      child: const Text('Ya, kosongkan'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.items.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 72,
                  color: Colors.grey,
                ),
                SizedBox(height: 12),
                Text('Keranjang masih kosong'),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final product = controller.items[index];
                  final quantity = controller.quantityOf(product);

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Harga: Rp ${product.price.toStringAsFixed(0)}'),
                          Text(
                            'Subtotal: Rp ${(product.price * quantity).toStringAsFixed(0)}',
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: quantity > 1
                                    ? () => controller.decreaseQuantity(product)
                                    : null,
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Text('$quantity'),
                              IconButton(
                                onPressed: () {
                                  controller.increaseQuantity(product);
                                },
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        tooltip: 'Hapus produk',
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          controller.removeFromCart(product);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Total item: ${controller.totalItem}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Total harga: Rp ${controller.totalHarga.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: () {
                      if (controller.items.isEmpty) {
                        Get.snackbar(
                          'Keranjang kosong',
                          'Tambahkan produk sebelum checkout.',
                          snackPosition: SnackPosition.TOP,
                        );
                        return;
                      }

                      Get.dialog(
                        AlertDialog(
                          title: const Text('Konfirmasi Checkout'),
                          content: Text(
                            'Total item: ${controller.totalItem}\n'
                            'Total pembayaran: Rp '
                            '${controller.totalHarga.toStringAsFixed(0)}\n\n'
                            'Apakah kamu ingin melanjutkan checkout?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Batal'),
                            ),

                            ElevatedButton(
                              onPressed: () {
                                controller.clearCart();

                                Get.back(); // Tutup dialog konfirmasi

                                Get.off(() => const CheckoutSuccessPage());
                              },
                              child: const Text('Konfirmasi'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
