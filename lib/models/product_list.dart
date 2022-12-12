import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((prod) => prod.isFavorite).toList();
  
  int get itemsCount => _items.length;

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
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
