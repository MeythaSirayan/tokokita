import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductService {
  static const String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl)); //request GET

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        return jsonData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception(
          'Gagal mengambil data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<Product> fetchProductDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      print('Detail Status Code: ${response.statusCode}');
      print('Detail Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        return Product.fromJson(jsonData);
      } else {
        throw Exception(
          'Gagal mengambil detail produk. '
          'Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error detail produk: $e');
      rethrow;
    }
  }
}
