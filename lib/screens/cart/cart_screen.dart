import 'package:fashion_app/services/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(cartControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: userState.when(
        data: (cartState) => _buildCartItems(cartState),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildCartItems(CartState cartState) {
    if (cartState.isEmpty) {
      return const Center(child: Text('Your cart is empty.'));
    }
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: cartState.items.length,
      itemBuilder: (context, index) {
        final item = cartState.items[index];
        return Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: ColoredBox(color: Color(item.product.swatchColorValue)),
            ),
            Expanded(
              child: ListTile(
                title: Text(item.product.name),
                subtitle: Text(
                  'Size: ${item.size}, Quantity: ${item.quantity}',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
