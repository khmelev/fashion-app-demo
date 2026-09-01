import 'package:flutter/widgets.dart';

import 'app_route_path.dart';

/// Converts between [RouteInformation] (e.g. the browser URL) and
/// [AppRoutePath], and back again.
class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = routeInformation.uri;
    if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'product') {
      return AppRoutePath.productDetail(uri.pathSegments[1]);
    }
    return const AppRoutePath.catalog();
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath configuration) {
    final location = configuration.isCatalog
        ? '/'
        : '/product/${configuration.productId}';
    return RouteInformation(uri: Uri.parse(location));
  }
}
