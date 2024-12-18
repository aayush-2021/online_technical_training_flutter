// ignore_for_file: public_member_api_docs, sort_constructors_first, invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "price") double? price,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "category") String? category,
    @JsonKey(name: "image") String? image,
    @JsonKey(name: "rating") Rating? rating,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

@freezed
class Rating with _$Rating {
  const factory Rating({
    @JsonKey(name: "rate") double? rate,
    @JsonKey(name: "count") int? count,
  }) = _Rating;

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
}


// Dart doesn't support Multiple Inheritance directly
// use mixin instead of class & `with` keyword instead of extends keyword