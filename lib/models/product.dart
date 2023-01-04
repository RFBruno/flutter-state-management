import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/product_list.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  void toggleFavorite(Product product, String auth, String uid) async {
    isFavorite = !isFavorite;
    notifyListeners();
    await http.patch(
      Uri.parse('${Constants.favoritetBaseUrl}/${uid}.json?auth=$auth'),
      body: jsonEncode({product.id : isFavorite}),
    );
  }
  
}
