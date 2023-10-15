import 'package:json_annotation/json_annotation.dart';

part 'color_model.g.dart';

@JsonSerializable()
class ColorModel {
  int colorId;
  String colorName;
  String colorHEXCode;

  ColorModel({
    required this.colorId,
    required this.colorName,
    required this.colorHEXCode,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) => _$ColorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ColorModelToJson(this);
}
