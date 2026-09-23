import 'package:collection/collection.dart';
import 'package:fashion_app/domain/models/product.dart';
import 'package:uuid/uuid.dart';

class CartState {
  final List<CartItem> _items;

  CartState({required this._items});

  factory CartState.empty() => CartState(items: []);

  factory CartState.addItem({
    required CartState? currentState,
    required Product product,
    required ProductSize size,
    required int quantity,
  }) {
    final items = currentState?.items ?? [];
    if (items.isNotEmpty &&
        items.any(
          (item) => item.product.id == product.id && item.size == size,
        )) {
      final updatedItems = items.map((item) {
        if (item.product.id == product.id && item.size == size) {
          return CartItem(
            product: item.product,
            size: item.size,
            quantity: item.quantity + quantity,
          );
        }
        return item;
      }).toList();
      return CartState(items: updatedItems);
    } else {
      return CartState(
        items: [
          ...items,
          CartItem(product: product, size: size, quantity: quantity),
        ],
      );
    }
  }

  factory CartState.changeQuantity({
    required CartState currentState,
    required String cartItemId,
    int qtyChange = 1,
  }) {
    final updatedItems = [...currentState.items];
    final cartItem = updatedItems.firstWhereOrNull(
      (item) => item.id == cartItemId,
    );
    if (cartItem != null) {
      int cartItemIndex = updatedItems.indexOf(cartItem);
      final newQty = cartItem.quantity + qtyChange;
      if (newQty > 0) {
        updatedItems[cartItemIndex] = cartItem.updateQty(newQty: newQty);
      } else {
        updatedItems.removeAt(cartItemIndex);
      }
    }
    return CartState(items: updatedItems);
  }

  List<CartItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;
}

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
