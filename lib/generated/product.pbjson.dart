// This is a generated file - do not edit.
//
// Generated from product.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use listProductsRequestDescriptor instead')
const ListProductsRequest$json = {
  '1': 'ListProductsRequest',
};

/// Descriptor for `ListProductsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listProductsRequestDescriptor =
    $convert.base64Decode('ChNMaXN0UHJvZHVjdHNSZXF1ZXN0');

@$core.Deprecated('Use listProductsResponseDescriptor instead')
const ListProductsResponse$json = {
  '1': 'ListProductsResponse',
  '2': [
    {
      '1': 'products',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.fashion.Product',
      '10': 'products'
    },
  ],
};

/// Descriptor for `ListProductsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listProductsResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0UHJvZHVjdHNSZXNwb25zZRIsCghwcm9kdWN0cxgBIAMoCzIQLmZhc2hpb24uUHJvZH'
    'VjdFIIcHJvZHVjdHM=');

@$core.Deprecated('Use getProductRequestDescriptor instead')
const GetProductRequest$json = {
  '1': 'GetProductRequest',
  '2': [
    {'1': 'product_id', '3': 1, '4': 1, '5': 9, '10': 'productId'},
  ],
};

/// Descriptor for `GetProductRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProductRequestDescriptor = $convert.base64Decode(
    'ChFHZXRQcm9kdWN0UmVxdWVzdBIdCgpwcm9kdWN0X2lkGAEgASgJUglwcm9kdWN0SWQ=');

@$core.Deprecated('Use productDescriptor instead')
const Product$json = {
  '1': 'Product',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    {'1': 'brand', '3': 4, '4': 1, '5': 9, '10': 'brand'},
    {'1': 'price', '3': 5, '4': 1, '5': 1, '10': 'price'},
    {'1': 'currency', '3': 6, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'sizes', '3': 7, '4': 3, '5': 9, '10': 'sizes'},
    {'1': 'color', '3': 8, '4': 1, '5': 9, '10': 'color'},
  ],
};

/// Descriptor for `Product`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List productDescriptor = $convert.base64Decode(
    'CgdQcm9kdWN0Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhoKCGNhdGVnb3'
    'J5GAMgASgJUghjYXRlZ29yeRIUCgVicmFuZBgEIAEoCVIFYnJhbmQSFAoFcHJpY2UYBSABKAFS'
    'BXByaWNlEhoKCGN1cnJlbmN5GAYgASgJUghjdXJyZW5jeRIUCgVzaXplcxgHIAMoCVIFc2l6ZX'
    'MSFAoFY29sb3IYCCABKAlSBWNvbG9y');
