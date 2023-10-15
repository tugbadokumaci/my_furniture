import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  int categoryId;
  String categoryName;
  String categoryImage;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
  });

  // String get imagePath => 'assets/images/$categoryImage.png';

  // Widget get imageWidget {
  //   Uint8List imageData = base64Decode(categoryImage);
  //   return Image.memory(
  //     imageData,
  //     fit: BoxFit.cover, // Resmin boyutlandırma ayarları
  //   );
  // }

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
