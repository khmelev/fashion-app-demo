import 'package:collection/collection.dart';
import 'package:fashion_app/models/cart.dart';
import 'package:fashion_app/models/product.dart';
import 'package:fashion_app/utils/const.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartController extends AsyncNotifier<CartState> {
  @override
  Future<CartState> build() async => CartState.empty();

  Future<void> addItem({
    required Product product,
    required ProductSize size,
    int quantity = 1,
  }) async {
    state = const AsyncValue.loading();
    await Future.delayed(mockShortDelay);
    state = AsyncValue.data(
      CartState.addItem(
        currentState: state.value!,
        product: product,
        size: size,
        quantity: quantity,
      ),
    );
  }

  Future<void> changeQty({
    required String cartItemId,
    required int qtyChange,
  }) async {
    //state = const AsyncValue.loading();
    //await Future.delayed(mockNetworkDelay);
    state = AsyncValue.data(
      CartState.changeQuantity(
        currentState: state.value!,
        cartItemId: cartItemId,
        qtyChange: qtyChange,
      ),
    );
  }

  bool get isEmpty => state.value!.isEmpty;
}

class CartState {
  final List<CartItem> _items;

  CartState({required this._items});

  factory CartState.empty() => CartState(items: []);

  factory CartState.addItem({
    required CartState currentState,
    required Product product,
    required ProductSize size,
    required int quantity,
  }) {
    if (currentState.items.any(
      (item) => item.product.id == product.id && item.size == size,
    )) {
      final updatedItems = currentState.items.map((item) {
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
          ...currentState.items,
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

final cartControllerProvider = AsyncNotifierProvider<CartController, CartState>(
  () => CartController(),
);
