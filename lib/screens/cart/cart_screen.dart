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
        data: (cartState) => cartState.isEmpty
            ? const Center(child: Text('Your cart is empty.'))
            : CartItemsWidget(items: cartState.items),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class CartItemsWidget extends ConsumerStatefulWidget {
  final List<CartItem> _items;

  const CartItemsWidget({super.key, required this._items});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartItemsState();
}

class _CartItemsState extends ConsumerState<CartItemsWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void didUpdateWidget(covariant CartItemsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    final addedItems = widget._items
        .where((item) => !oldWidget._items.contains(item))
        .toList();

    for (final addedItem in addedItems) {
      final index = widget._items.indexOf(addedItem);
      _listKey.currentState?.insertItem(index);
    }

    final removedItems = oldWidget._items
        .where((item) => !widget._items.contains(item))
        .toList();

    for (final removedItem in removedItems) {
      final index = oldWidget._items.indexOf(removedItem);
      _listKey.currentState?.removeItem(index, (context, animation) {
        return _buildItem(removedItem, ref, animation);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: widget._items.length,
      itemBuilder: (context, index, animation) {
        return _buildItem(widget._items[index], ref, animation);
      },
    );
  }

  Widget _buildItem(CartItem item, WidgetRef ref, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        child: ListTile(
          leading: SizedBox(
            width: 50,
            height: 50,
            child: ColoredBox(color: Color(item.product.swatchColorValue)),
          ),
          title: Text(item.product.name),
          subtitle: Text('Size: ${item.size}'),
          trailing: _quantityControl(item, ref),
        ),
      ),
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
