import 'package:fashion_app/data/services/shop_service.dart';
import 'package:fashion_app/generated/product.pbgrpc.dart' as pb;
import 'package:fashion_app/domain/models/product.dart';
import 'package:grpc/grpc.dart';

final class ShopServiceRemote implements ShopService {
  ShopServiceRemote({required this._channel, required this._client});

  final ClientChannel _channel;
  final pb.ProductServiceClient _client;

  static ShopServiceRemote build({
    String host = 'localhost',
    int port = 50051,
  }) {
    final channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final client = pb.ProductServiceClient(channel);

    return ShopServiceRemote(channel: channel, client: client);
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
