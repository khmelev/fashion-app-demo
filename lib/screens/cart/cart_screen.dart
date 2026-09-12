import 'package:fashion_app/models/cart.dart';
import 'package:fashion_app/services/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerState = ref.watch(cartControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: providerState.when(
        data: (cartState) => _buildCartItems(cartState, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildCartItems(CartState cartState, WidgetRef ref) {
    if (cartState.isEmpty) {
      return const Center(child: Text('Your cart is empty.'));
    }
    return ListView.builder(
      itemCount: cartState.items.length,
      itemBuilder: (context, index) {
        final item = cartState.items[index];
        return ListTile(
          leading: SizedBox(
            width: 50,
            height: 50,
            child: ColoredBox(color: Color(item.product.swatchColorValue)),
          ),
          title: Text(item.product.name),
          subtitle: Text('Size: ${item.size}'),
          trailing: _quantityControl(item, ref),
        );
      },
    );
  }

  Widget _quantityControl(CartItem cartItem, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => {
            ref
                .read(cartControllerProvider.notifier)
                .changeQty(cartItemId: cartItem.id, qtyChange: -1),
          },
          icon: Icon(Icons.remove),
          constraints: BoxConstraints(minWidth: 40, minHeight: 40),
        ),

        SizedBox(width: 8),
        Text(
          '${cartItem.quantity}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        IconButton(
          onPressed: () => {
            ref
                .read(cartControllerProvider.notifier)
                .changeQty(cartItemId: cartItem.id, qtyChange: 1),
          },
          icon: Icon(Icons.add),
          constraints: BoxConstraints(minWidth: 40, minHeight: 40),
        ),
      ],
    );
  }
}
