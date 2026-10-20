import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/main_page.dart';
import 'screens/home_page.dart';
import 'screens/product_detail_page.dart';
import 'models/product.dart';
import 'controllers/cart_controller.dart';

void main() {
  Get.put(CartController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TokoKita',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),

      home: const MainPage(),

      routes: {
        '/detail': (context) {
          final product = ModalRoute.of(context)!.settings.arguments as Product;

          return ProductDetailPage(product: product);
        },
      },
    );
  }
}
