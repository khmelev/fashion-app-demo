import 'package:fashion_app/screens/cart/cart_screen.dart';
import 'package:fashion_app/screens/catalog/catalog_screen.dart';
import 'package:fashion_app/screens/main_screen.dart';
import 'package:fashion_app/screens/product_detail/product_detail_screen.dart';
import 'package:fashion_app/screens/profile/profile_container_screen.dart';
import 'package:fashion_app/utils/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

class FashionApp extends ConsumerStatefulWidget {
  const FashionApp({super.key});

  @override
  ConsumerState<FashionApp> createState() => _FashionAppState();
}

class _FashionAppState extends ConsumerState<FashionApp> {
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
                name: 'catalog',
                builder: (context, state) => CatalogScreen(),
              ),
              GoRoute(
                path: '/product/:id',
                name: 'product_detail',
                builder: (context, state) =>
                    ProductDetailScreen(productId: state.pathParameters['id']!),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(path: '/cart', builder: (context, state) => CartScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/profile',
                builder: (context, state) => ProfileContainerScreen(),
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
      darkTheme: AppTheme.dark,
      themeMode: ref.watch(themeNotifierProvider).isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      routerConfig: _router,
    );
  }
}
