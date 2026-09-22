import 'package:fashion_app/utils/fake_data.dart';
import 'package:fashion_app/data/services/shop_service.dart';
import 'package:fashion_app/domain/models/product.dart';
import 'package:fashion_app/utils/mock_const.dart';

final class ShopServiceLocal implements ShopService {
  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(mockLongDelay);
    return fakeProducts;
  }

  @override
  Future<List<Product>> getSimilarProducts(String productId) async {
    await Future.delayed(mockMiddleDelay);
    return fakeProducts.where((item) => item.id != productId).toList();
  }

  @override
  Future<Product> getProduct(String productId) async {
    await Future.delayed(mockMiddleDelay);
    return fakeProducts.firstWhere((item) => item.id == productId);
  }
}
