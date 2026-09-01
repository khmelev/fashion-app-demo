import 'package:flutter/material.dart';

import '../utils/theme.dart';
import 'app_route_information_parser.dart';
import 'app_router_delegate.dart';

/// Root widget wiring up manual Navigator 2.0 routing for the app.
class FashionApp extends StatefulWidget {
  const FashionApp({super.key});

  @override
  State<FashionApp> createState() => _FashionAppState();
}

class _FashionAppState extends State<FashionApp> {
  final _routerDelegate = AppRouterDelegate();
  final _routeInformationParser = AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fashion App',
      theme: AppTheme.light,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
