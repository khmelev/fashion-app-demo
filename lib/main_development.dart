import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fashion_app/main.dart';
import 'package:fashion_app/services/product_service.dart';

void main() {
  runApp(
    ProviderScope(
      retry: (retryCount, error) => null,
      overrides: [
        productServiceProvider.overrideWith((ref) {
          return MockProductService();
        }),
      ],
      child: FashionApp(),
    ),
  );
}
