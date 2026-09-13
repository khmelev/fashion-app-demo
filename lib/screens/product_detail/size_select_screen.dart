import 'package:fashion_app/services/cart_controller.dart';
import 'package:fashion_app/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SizeSelectScreen extends ConsumerWidget {
  const SizeSelectScreen({super.key, required this._productId});

  final String _productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerState = ref.watch(productProvider(_productId));
    return providerState.when(
      data: (product) {
        final sizes = product.sizes;
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Size',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sizes.length,
                  itemBuilder: (context, index) {
                    final size = sizes[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(cartControllerProvider.notifier)
                              .addItem(
                                product: product,
                                size: size,
                                quantity: 1,
                              )
                              .then((value) {
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              });
                        },
                        child: Container(
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              size.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}
