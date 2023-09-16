import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  int productId;
  String productName;
  String productDescription;
  int productPrice;
  // int productImage;
  int productCategoryId;

  ProductModel(
      {required this.productId,
      required this.productName,
      required this.productDescription,
      required this.productPrice,
      // required this.productImage,
      required this.productCategoryId});

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
