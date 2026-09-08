import 'product.dart';

class Cart {
  Cart({required this.items});

  final List<CartItem> items;
}

class CartItem {
  CartItem({required this.product, required this.size});

  final Product product;
  final ProductSize size;
}
