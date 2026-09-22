import 'package:flutter/material.dart';

import 'package:fashion_app/domain/models/product.dart';

final List<Product> fakeProducts = List.unmodifiable([
  Product(
    id: 'p1',
    name: 'Classic White Tee',
    price: 24.99,
    swatchColorValue: Colors.indigo.shade200.toARGB32(),
    description: 'A timeless crewneck t-shirt in 100% organic cotton.',
  ),
  Product(
    id: 'p2',
    name: 'Denim Jacket',
    price: 89.00,
    swatchColorValue: Colors.blue.shade700.toARGB32(),
    description: 'A mid-wash denim jacket with a relaxed fit.',
  ),
  Product(
    id: 'p3',
    name: 'Wool Overcoat',
    price: 149.50,
    swatchColorValue: Colors.brown.shade400.toARGB32(),
    description: 'A tailored wool-blend overcoat for cooler weather.',
  ),
  Product(
    id: 'p4',
    name: 'Silk Scarf',
    price: 34.00,
    swatchColorValue: Colors.pink.shade200.toARGB32(),
    description: 'A hand-finished silk scarf with a subtle sheen.',
  ),
  Product(
    id: 'p5',
    name: 'Leather Boots',
    price: 120.00,
    swatchColorValue: Colors.brown.shade800.toARGB32(),
    description: 'Full-grain leather boots with a stacked heel.',
  ),
  Product(
    id: 'p6',
    name: 'Knit Sweater',
    price: 64.00,
    swatchColorValue: Colors.teal.shade300.toARGB32(),
    description: 'A chunky-knit sweater in a soft wool blend.',
  ),
]);
