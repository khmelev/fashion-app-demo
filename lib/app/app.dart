import 'package:fashion_app/screens/cart/cart_screen.dart';
import 'package:fashion_app/screens/catalog/catalog_screen.dart';
import 'package:fashion_app/screens/main_screen.dart';
import 'package:fashion_app/screens/product_detail/product_detail_screen.dart';
import 'package:fashion_app/utils/fake_data.dart';
import 'package:fashion_app/utils/theme.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

class FashionApp extends StatefulWidget {
  const FashionApp({super.key});

  @override
  State<FashionApp> createState() => _FashionAppState();
}

class _FashionAppState extends State<FashionApp> {
  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/catalog',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainScreen(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/catalog',
                builder: (context, state) => CatalogScreen(
                  onProductSelected: (product) =>
                      GoRouter.of(context).go('/catalog/product/${product.id}'),
                ),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'product/:id',
                    builder: (context, state) {
                      final productId = state.pathParameters['id']!;
                      final product = fakeProducts.firstWhere(
                        (element) => element.id == productId,
                      );
                      return ProductDetailScreen(product: product);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/cart',
                builder: (context, state) {
                  return CartScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fashion App',
      theme: AppTheme.light,
      routerConfig: _router,
    );
  }
}
