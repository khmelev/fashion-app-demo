/// A single product in the catalog.
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.swatchColorValue,
    required this.description,
    this.sizes = const [.s, .m, .l, .xl],
  });

  final String id;
  final String name;
  final double price;

  /// ARGB color value used as a placeholder swatch in place of a real image.
  final int swatchColorValue;
  final String description;

  final List<ProductSize> sizes;
}

class ProductSize {
  const ProductSize({required this.id, required this.name});

  final String id;
  final String name;

  static const ProductSize s = ProductSize(id: "s", name: "S");
  static const ProductSize m = ProductSize(id: "m", name: "M");
  static const ProductSize l = ProductSize(id: "l", name: "L");
  static const ProductSize xl = ProductSize(id: "xl", name: "XL");

  @override
  toString() => name;
}
