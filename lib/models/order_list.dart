import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';

class OrderList with ChangeNotifier {
  final _baseUrl = Constants.ordersBaseUrl;

  List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.ordersBaseUrl}.json'),
      body: jsonEncode(
        {
          'total': cart.totalAmount,
          'data': date.toIso8601String(),
          'products': cart.items.values
              .map((cartItem) => {
                    'id': cartItem.id,
                    'productId': cartItem.productId,
                    'name': cartItem.name,
                    'quantity': cartItem.quantity,
                    'price': cartItem.price,
                  })
              .toList()
        },
      ),
    );
    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: double.parse(cart.totalAmount),
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> loadOrders() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('$_baseUrl.json'),
    );

    if (jsonDecode(response.body) == null) return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderData) {
      _items.add(Order(
        id: orderId,
        total: double.parse(orderData['total']),
        products: (orderData['products'] as List<dynamic>).map((el) {
          return CartItem(
            id: orderId,
            productId: orderId,
            name: el['name'],
            quantity: el['quantity'],
            price: el['price'],
          );
        }).toList(),
        date: DateTime.parse( orderData['data']),
      ));
    });
    notifyListeners();
  }
}
