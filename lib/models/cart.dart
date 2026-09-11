import 'package:uuid/uuid.dart';

import 'product.dart';

class CartItem {
  CartItem({required this.product, required this.size, required this.quantity});

  CartItem updateQty({required int newQty}) {
    return CartItem(product: product, size: size, quantity: newQty);
  }

  final String id = const Uuid().v4();
  final Product product;
  final ProductSize size;
  final int quantity;
}
