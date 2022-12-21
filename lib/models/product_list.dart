import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/constants.dart';

class ProductList with ChangeNotifier {
  final _baseUrl = Constants.productBaseUrl;
  List<Product> _items = []; // dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount => _items.length;

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('$_baseUrl.json'),
    );

    if (jsonDecode(response.body) == null) return;
    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: double.parse(productData['price'].toString()),
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$_baseUrl.json'),
      body: jsonEncode({
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isFavorite
      }),
    );

    final id = jsonDecode(response.body)['name'];

    _items.add(
      Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      ),
    );
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('$_baseUrl/${product.id}.json'),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> updateProductFavorites(Product product) async {
      await http.patch(
        Uri.parse('$_baseUrl/${product.id}.json'),
        body: jsonEncode({
          "isFavorite": product.isFavorite
        }),
      );
  }

  Future<void> removeProduct(Product product) async {
    final index = _items.indexWhere((p) => p.id == product.id);
    _items.remove(product);
    notifyListeners();

    final response = await http.delete(
      Uri.parse('$_baseUrl/${product.id}'),
    );

    if (response.statusCode >= 400) {
      _items.insert(index, product);
      throw HttpException(
        msg: 'Não foi possível excluir o produto.',
        statusCode: response.statusCode,
      );
    }
  }
}

// Logica versão global v1
// bool _showFavorite = false;
// List<Product> get items {
//     if(_showFavorite){
//       return _items.where((prod) => prod.isFavorite).toList();
//     }
//     return [..._items];
//   }

//   void showFavorite(){
//     _showFavorite = true;
//     notifyListeners();
//   }

//   void showAll(){
//     _showFavorite = false;
//     notifyListeners();
//   }
