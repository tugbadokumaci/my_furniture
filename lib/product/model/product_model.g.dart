// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      productDescription: json['productDescription'] as String,
      productPrice: json['productPrice'] as int,
      // productImage: json['productImage'] as int,
      productCategoryId: json['productCategoryId'] as int,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) => <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'productDescription': instance.productDescription,
      'productPrice': instance.productPrice,
      // 'productImage': instance.productImage,
      'productCategoryId': instance.productCategoryId,
    };
