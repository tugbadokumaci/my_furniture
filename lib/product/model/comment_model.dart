import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  int commentId;
  int productId;
  int userId;
  int commentRate;
  String comment;
  DateTime commentTime;

  CommentModel(
      {required this.commentId,
      required this.productId,
      required this.userId,
      required this.commentRate,
      required this.comment,
      required this.commentTime});

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
