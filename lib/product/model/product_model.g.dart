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
    productImage: (json['productImage'] as List<dynamic>).map((e) => e as String).toList(),
    productCategoryId: json['productCategoryId'] as int,
    productColors:
        (json['productColors'] as List<dynamic>).map((e) => ColorModel.fromJson(e as Map<String, dynamic>)).toList(),
    comments: (json['comments'] as List<dynamic>).map((e) => CommentModel.fromJson(e as Map<String, dynamic>)).toList(),
    productIsFav: json['productIsFav'] as int);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) => <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'productDescription': instance.productDescription,
      'productPrice': instance.productPrice,
      'productImage': instance.productImage,
      'productCategoryId': instance.productCategoryId,
      'productColors': instance.productColors,
      'comments': instance.comments,
      'productIsFav': instance.productIsFav,
    };
