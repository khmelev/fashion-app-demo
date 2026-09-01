/// Represents a parsed navigation location within the app.
class AppRoutePath {
  const AppRoutePath.catalog() : productId = null;
  const AppRoutePath.productDetail(String this.productId);

  final String? productId;

  bool get isCatalog => productId == null;
}
