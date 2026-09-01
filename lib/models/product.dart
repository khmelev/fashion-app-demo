/// A single product in the catalog.
///
/// This mirrors the shape of the product message the gRPC backend will
/// eventually return, but stays a plain Dart class with no dependency on
/// generated protobuf code so the UI can be built against fake data first.
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.swatchColorValue,
    required this.description,
  });

  final String id;
  final String name;
  final double price;

  /// ARGB color value used as a placeholder swatch in place of a real image.
  final int swatchColorValue;
  final String description;
}
