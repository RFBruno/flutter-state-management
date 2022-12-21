import 'package:flutter/cupertino.dart';
import 'package:shop/models/product_list.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false
  });

  void toggleFavorite(Product product){
    isFavorite = !isFavorite;
    notifyListeners();
    ProductList().updateProductFavorites(product);
  }
}