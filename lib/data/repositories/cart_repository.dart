import 'package:fashion_app/domain/models/cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fashion_app/domain/models/product.dart';
import 'package:fashion_app/data/repositories/customer_repository.dart';
import 'package:fashion_app/utils/mock_const.dart';
import 'package:fashion_app/utils/fake_data.dart';

class CartRepository extends AsyncNotifier<CartState> {
  @override
  Future<CartState> build() async {
    if (ref.read(customerRepositoryProvider).value.isAuthorized) {
      return CartState(
        items: [
          CartItem(product: fakeProducts[0], size: .m, quantity: 1),
          CartItem(product: fakeProducts[1], size: .s, quantity: 1),
          CartItem(product: fakeProducts[2], size: .l, quantity: 2),
        ],
      );
    } else {
      return CartState.empty();
    }
  }

  Future<void> addItem({
    required Product product,
    required ProductSize size,
    int quantity = 1,
  }) async {
    state = const AsyncValue.loading();
    await Future.delayed(mockShortDelay);
    state = AsyncValue.data(
      CartState.addItem(
        currentState: state.value,
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

final cartRepositoryProvider = AsyncNotifierProvider<CartRepository, CartState>(
  () => CartRepository(),
);
