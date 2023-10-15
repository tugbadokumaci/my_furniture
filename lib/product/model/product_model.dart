import 'package:json_annotation/json_annotation.dart';
import 'package:my_furniture/product/model/color_model.dart';
import 'package:my_furniture/product/model/comment_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  int productId;
  String productName;
  String productDescription;
  int productPrice;
  List<String> productImage;
  int productCategoryId;
  List<ColorModel> productColors;
  List<CommentModel> comments;
  int productIsFav;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
    required this.productCategoryId,
    required this.productColors,
    required this.comments,
    required this.productIsFav,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
