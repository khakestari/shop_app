import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String? authToken;
  Orders(this.authToken, this._orders);
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.https('test-4f7c9-default-rtdb.firebaseio.com',
        '/orders.json?auth=$authToken');
    final response = await http.get(url);
    // print(response.body);
    final List<OrderItem> loadedOrders = [];
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    // ignore: unnecessary_null_comparison
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        products: (orderData['products'] as List<dynamic>)
            .map((item) => CartItem(
                id: item['id'],
                title: item['title'],
                quantity: item['quantity'],
                price: item['price']))
            .toList(),
        dateTime: DateTime.parse(orderData['dateTime']),
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.https('test-4f7c9-default-rtdb.firebaseio.com',
        '/orders.json?auth=$authToken');
    final timestamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: jsonEncode({
            'amount': total,
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList(),
            'dateTime': timestamp.toIso8601String(),
          }));
      _orders.insert(
          0,
          OrderItem(
            id: jsonDecode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: timestamp,
          ));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
