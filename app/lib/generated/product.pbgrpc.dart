// This is a generated file - do not edit.
//
// Generated from product.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'product.pb.dart' as $0;

export 'product.pb.dart';

/// ProductService lets clients browse the fashion catalog.
@$pb.GrpcServiceName('fashion.ProductService')
class ProductServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ProductServiceClient(super.channel, {super.options, super.interceptors});

  /// ListProducts returns a fixed catalog of products.
  $grpc.ResponseFuture<$0.ListProductsResponse> listProducts(
    $0.ListProductsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listProducts, request, options: options);
  }

  /// GetProduct returns a single product by id.
  $grpc.ResponseFuture<$0.Product> getProduct(
    $0.GetProductRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getProduct, request, options: options);
  }

  /// GetSimilar returns up to 10 products other than the given id.
  $grpc.ResponseFuture<$0.ListProductsResponse> getSimilar(
    $0.GetProductRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSimilar, request, options: options);
  }

  // method descriptors

  static final _$listProducts =
      $grpc.ClientMethod<$0.ListProductsRequest, $0.ListProductsResponse>(
          '/fashion.ProductService/ListProducts',
          ($0.ListProductsRequest value) => value.writeToBuffer(),
          $0.ListProductsResponse.fromBuffer);
  static final _$getProduct =
      $grpc.ClientMethod<$0.GetProductRequest, $0.Product>(
          '/fashion.ProductService/GetProduct',
          ($0.GetProductRequest value) => value.writeToBuffer(),
          $0.Product.fromBuffer);
  static final _$getSimilar =
      $grpc.ClientMethod<$0.GetProductRequest, $0.ListProductsResponse>(
          '/fashion.ProductService/GetSimilar',
          ($0.GetProductRequest value) => value.writeToBuffer(),
          $0.ListProductsResponse.fromBuffer);
}

@$pb.GrpcServiceName('fashion.ProductService')
abstract class ProductServiceBase extends $grpc.Service {
  $core.String get $name => 'fashion.ProductService';

  ProductServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.ListProductsRequest, $0.ListProductsResponse>(
            'ListProducts',
            listProducts_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ListProductsRequest.fromBuffer(value),
            ($0.ListProductsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetProductRequest, $0.Product>(
        'GetProduct',
        getProduct_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetProductRequest.fromBuffer(value),
        ($0.Product value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetProductRequest, $0.ListProductsResponse>(
            'GetSimilar',
            getSimilar_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetProductRequest.fromBuffer(value),
            ($0.ListProductsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ListProductsResponse> listProducts_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListProductsRequest> $request) async {
    return listProducts($call, await $request);
  }

  $async.Future<$0.ListProductsResponse> listProducts(
      $grpc.ServiceCall call, $0.ListProductsRequest request);

  $async.Future<$0.Product> getProduct_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetProductRequest> $request) async {
    return getProduct($call, await $request);
  }

  $async.Future<$0.Product> getProduct(
      $grpc.ServiceCall call, $0.GetProductRequest request);

  $async.Future<$0.ListProductsResponse> getSimilar_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetProductRequest> $request) async {
    return getSimilar($call, await $request);
  }

  $async.Future<$0.ListProductsResponse> getSimilar(
      $grpc.ServiceCall call, $0.GetProductRequest request);
}
