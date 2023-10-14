// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      commentId: json['commentId'] as int,
      productId: json['productId'] as int,
      userId: json['userId'] as int,
      commentRate: json['commentRate'] as int,
      comment: json['comment'] as String,
      commentTime: DateTime.parse(json['commentTime'] as String),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'productId': instance.productId,
      'userId': instance.userId,
      'commentRate': instance.commentRate,
      'comment': instance.comment,
      'commentTime': instance.commentTime.toIso8601String(),
    };
