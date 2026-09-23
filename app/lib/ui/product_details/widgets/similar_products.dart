import 'package:fashion_app/domain/models/product.dart';
import 'package:fashion_app/data/repositories/product_repository.dart';
import 'package:fashion_app/ui/core/widgets/skeleton.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SimilarProducts extends ConsumerWidget {
  const SimilarProducts({super.key, required this._productId});

  final String _productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerState = ref.watch(similarProductsProvider(_productId));
    return providerState.when(
      data: (similarProducts) {
        return _body(
          context: context,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: similarProducts.length,
            itemBuilder: (context, index) {
              return _similarItemBuilder(context, similarProducts[index]);
            },
          ),
        );
      },
      loading: () {
        return _body(
          context: context,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 12),
                child: AnimatedSkeleton(height: 50, width: 50),
              );
            },
          ),
        );
      },
      error: (error, stackTrace) => SizedBox(height: 20),
    );
  }

  Widget _body({required BuildContext context, required Widget child}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Similar products',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 20),
        SizedBox(height: 50, child: child),
      ],
    );
  }

  Widget? _similarItemBuilder(BuildContext context, Product item) {
    return Padding(
      padding: EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {
          GoRouter.of(
            context,
          ).pushNamed('product_detail', pathParameters: {'id': item.id});
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(item.swatchColorValue),
          ),
        ),
      ),
    );
  }
}
