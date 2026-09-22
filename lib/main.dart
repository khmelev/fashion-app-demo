import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fashion_app/routing/router.dart';
import 'package:fashion_app/utils/theme.dart';

void main() {
  runApp(
    ProviderScope(retry: (retryCount, error) => null, child: FashionApp()),
  );
}

class FashionApp extends ConsumerWidget {
  const FashionApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Fashion App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ref.watch(themeNotifierProvider).isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      routerConfig: router(),
    );
  }
}
