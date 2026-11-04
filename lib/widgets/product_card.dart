import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product.dart';
import '../controllers/favorite_controller.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  // Tambahan untuk navigasi
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final FavoriteController favoriteController = Get.find<FavoriteController>();

  @override
  void initState() {
    super.initState();

    print('[${widget.product.name}] initState dipanggil');
  }

  @override
  Widget build(BuildContext context) {
    print(
      '[${widget.product.name}] build dipanggil '
      '(isFavorite: ${favoriteController.isFavorite(widget.product.id)})',
    );

    return InkWell(
      // Ketika ProductCard ditekan
      onTap: widget.onTap,

      borderRadius: BorderRadius.circular(16),

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(50),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GAMBAR + BADGE STOK
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.shopping_bag,
                    size: 45,
                    color: Colors.grey,
                  ),
                ),

                // BADGE DISKON
                if (widget.product is DiscountedProduct)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: DiscountBadge(
                      discount:
                          (widget.product as DiscountedProduct).discountPercent,
                    ),
                  ),

                // BADGE STATUS STOK
                Positioned(
                  left: 5,
                  bottom: 5,
                  child: StockBadge(status: widget.product.getStatusStok()),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // INFORMASI PRODUK
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      widget.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  CategoryTag(category: widget.product.category),

                  const SizedBox(height: 6),

                  PriceLabel(price: widget.product.price),
                ],
              ),
            ),

            // TOMBOL FAVORITE
            Obx(() {
              final isFavorite = favoriteController.isFavorite(
                widget.product.id,
              );

              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),

                onPressed: () async {
                  await favoriteController.toggleFavorite(widget.product.id);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('[${widget.product.name}] dispose dipanggil');

    super.dispose();
  }
}

// PRICE LABEL

class PriceLabel extends StatelessWidget {
  final double price;

  const PriceLabel({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Rp ${price.toStringAsFixed(0)}',
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: Colors.green,
      ),
    );
  }
}

// STOCK BADGE

class StockBadge extends StatelessWidget {
  final String status;

  const StockBadge({super.key, required this.status});

  Color _getColor() {
    switch (status) {
      case 'Tersedia':
        return Colors.green;

      case 'Stok Terbatas':
        return Colors.orange;

      case 'Habis':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(38),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// CATEGORY TAG

class CategoryTag extends StatelessWidget {
  final String category;

  const CategoryTag({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.teal.withAlpha(38),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        category,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.teal,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// DISCOUNT BADGE

class DiscountBadge extends StatelessWidget {
  final double discount;

  const DiscountBadge({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Diskon ${discount.toStringAsFixed(0)}%',
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
