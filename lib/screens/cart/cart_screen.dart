import 'package:fashion_app/services/cart_service.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this._cartService});

  final CartService _cartService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ListenableBuilder(
        listenable: _cartService,
        builder: (context, child) {
          return _buildCartItems();
        },
      ),
    );
  }

  Widget _buildCartItems() {
    if (_cartService.isEmpty) {
      return const Center(child: Text('Your cart is empty.'));
    }
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _cartService.items.length,
      itemBuilder: (context, index) {
        final item = _cartService.items[index];
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
