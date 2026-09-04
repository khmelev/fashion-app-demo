import 'package:fashion_app/screens/main_page.dart';
import 'package:flutter/material.dart';

import 'package:fashion_app/utils/theme.dart';

class FashionApp extends StatefulWidget {
  const FashionApp({super.key});

  @override
  State<FashionApp> createState() => _FashionAppState();
}

class _FashionAppState extends State<FashionApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion App',
      theme: AppTheme.light,
      home: MainPage(),
    );
  }
}
