import 'package:fashion_app/generated/product.pbgrpc.dart' as pb;
import 'package:fashion_app/models/product.dart';
import 'package:fashion_app/utils/const.dart';
import 'package:fashion_app/utils/fake_data.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

const bool _useMocks = true;

abstract class ProductService {
  Future<List<Product>> getProducts();
  Future<List<Product>> getSimilarProducts(String productId);
  Future<Product> getProduct(String productId);
}

class _GrpcProductService implements ProductService {
  late ClientChannel _channel;
  late pb.ProductServiceClient _client;

  Future<void> initialize({String host = 'localhost', int port = 50051}) async {
    _channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        connectTimeout: Duration(seconds: 2),
      ),
    );

    _client = pb.ProductServiceClient(_channel);
  }

  @override
  Future<List<Product>> getProducts() async {
    final response = await _client.listProducts(pb.ListProductsRequest());
    return response.products.map((pbProduct) {
      return Product(
        id: pbProduct.id,
        name: pbProduct.name,
        description: pbProduct.category,
        price: pbProduct.price,
        swatchColorValue: int.parse(pbProduct.color),
      );
    }).toList();
  }

  @override
  Future<Product> getProduct(String productId) async {
    final product = await _client.getProduct(
      pb.GetProductRequest(productId: productId),
    );
    return Product(
      id: product.id,
      name: product.name,
      description: product.category,
      price: product.price,
      swatchColorValue: int.parse(product.color),
    );
  }

  @override
  Future<List<Product>> getSimilarProducts(String productId) async {
    final response = await _client.getSimilar(
      pb.GetProductRequest(productId: productId),
    );
    return response.products.map((pbProduct) {
      return Product(
        id: pbProduct.id,
        name: pbProduct.name,
        description: pbProduct.category,
        price: pbProduct.price,
        swatchColorValue: int.parse(pbProduct.color),
      );
    }).toList();
  }

  Future<void> shutdown() async {
    await _channel.shutdown();
  }
}

class _MockProductService implements ProductService {
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

final mockProductServiceProvider = FutureProvider<ProductService>((ref) async {
  if (_useMocks) {
    return _MockProductService();
  } else {
    final productService = _GrpcProductService();
    await productService.initialize();

    ref.onDispose(() => productService.shutdown());

    return productService;
  }
});
