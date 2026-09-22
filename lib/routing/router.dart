import 'package:fashion_app/routing/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:fashion_app/ui/cart/widgets/cart_screen.dart';
import 'package:fashion_app/ui/catalog/widgets/catalog_screen.dart';
import 'package:fashion_app/ui/main/main_screen.dart';
import 'package:fashion_app/ui/product_details/widgets/product_detail_screen.dart';
import 'package:fashion_app/ui/profile/widgets/profile_container_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

GoRouter router() => GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: Routes.catalog,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainScreen(navigationShell: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: Routes.catalog,
              name: 'catalog',
              builder: (context, state) => CatalogScreen(),
            ),
            GoRoute(
              path: Routes.productDetails,
              name: 'product_detail',
              builder: (context, state) =>
                  ProductDetailScreen(productId: state.pathParameters['id']!),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: Routes.cart,
              builder: (context, state) => CartScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: Routes.profile,
              builder: (context, state) => ProfileContainerScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
