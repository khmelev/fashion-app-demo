import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/catalog/catalog_screen.dart';
import '../screens/product_detail/product_detail_screen.dart';
import '../utils/fake_data.dart';
import 'app_route_path.dart';

/// Owns the navigation stack (catalog, and optionally a selected product's
/// detail page on top of it) and rebuilds it in response to app state.
class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  Product? _selectedProduct;

  void _selectProduct(Product product) {
    _selectedProduct = product;
    notifyListeners();
  }

  void _clearSelection() {
    _selectedProduct = null;
    notifyListeners();
  }

  @override
  AppRoutePath get currentConfiguration {
    final selected = _selectedProduct;
    return selected == null
        ? const AppRoutePath.catalog()
        : AppRoutePath.productDetail(selected.id);
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selectedProduct;
    return Navigator(
      key: navigatorKey,
      onDidRemovePage: (page) => _clearSelection(),
      pages: [
        MaterialPage(
          key: const ValueKey('catalog'),
          child: CatalogScreen(onProductSelected: _selectProduct),
        ),
        if (selected != null)
          MaterialPage(
            key: ValueKey('product-${selected.id}'),
            child: ProductDetailScreen(product: selected),
          ),
      ],
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    if (configuration.isCatalog) {
      _selectedProduct = null;
      return;
    }
    final matches = fakeProducts.where(
      (product) => product.id == configuration.productId,
    );
    _selectedProduct = matches.isEmpty ? null : matches.first;
  }
}
