import 'package:fashion_app/models/product.dart';
import 'package:fashion_app/utils/const.dart';
import 'package:fashion_app/utils/fake_data.dart';

class ProductService {
  static final ProductService _instance = ProductService._internal();

  factory ProductService() {
    return _instance;
  }

  ProductService._internal();

  Future<List<Product>> getProducts() async {
    await Future.delayed(mockNetworkDelay);
    return fakeProducts;
  }
}
