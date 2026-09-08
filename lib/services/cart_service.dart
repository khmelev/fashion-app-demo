import 'package:fashion_app/models/cart.dart';
import 'package:fashion_app/models/product.dart';
import 'package:fashion_app/utils/const.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();

  factory CartService() {
    return _instance;
  }

  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  Future<void> addItem({
    required Product product,
    required ProductSize size,
    int quantity = 1,
  }) async {
    await Future.delayed(mockNetworkDelay);
    _items.add(CartItem(product: product, size: size, quantity: quantity));
    notifyListeners();
  }

  bool get isEmpty => _items.isEmpty;
}

final cartServiceProvider = Provider<CartService>((ref) => CartService());
