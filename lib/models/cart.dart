import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  String get totalAmount {
    double total = 0.0;

    _items.forEach((key, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });

    return total.toStringAsFixed(2);
  }

  void addItem(Product product) {
    var condition = _items.containsKey(product.id);
    if (condition) {
      updateItemQuantity(product.id, 1);
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );

      notifyListeners();
    }
  }

  void updateItemQuantity(String productId, int value) {
    _items.update(
      productId,
      (item) => CartItem(
        id: item.id,
        productId: item.productId,
        name: item.name,
        quantity: item.quantity + (value),
        price: item.price,
      ),
    );
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {

    if (_items[productId]?.quantity == 1) {
      removeItem(productId);
    }else{
      updateItemQuantity(productId, -1);
    }
    
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
