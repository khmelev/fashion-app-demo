import 'package:fashion_app/data/services/shop_service_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fashion_app/main.dart';
import 'package:fashion_app/data/services/shop_service.dart';

void main() {
  runApp(
    ProviderScope(
      retry: (retryCount, error) => null,
      overrides: [
        shopServiceProvider.overrideWith((ref) => ShopServiceLocal()),
      ],
      child: FashionApp(),
    ),
  );
}
