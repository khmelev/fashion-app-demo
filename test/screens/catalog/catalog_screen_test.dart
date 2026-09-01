import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fashion_app/models/product.dart';
import 'package:fashion_app/screens/catalog/catalog_screen.dart';
import 'package:fashion_app/utils/fake_data.dart';

void main() {
  testWidgets('shows every product and reports taps', (tester) async {
    // Use a tall surface so every product tile is laid out without scrolling.
    await tester.binding.setSurfaceSize(const Size(800, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    Product? tapped;

    await tester.pumpWidget(
      MaterialApp(
        home: CatalogScreen(onProductSelected: (product) => tapped = product),
      ),
    );

    for (final product in fakeProducts) {
      expect(find.text(product.name), findsOneWidget);
    }

    await tester.tap(find.text(fakeProducts.first.name));
    await tester.pump();

    expect(tapped, fakeProducts.first);
  });
}
