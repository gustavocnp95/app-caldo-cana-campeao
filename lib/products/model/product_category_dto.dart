import 'package:json_annotation/json_annotation.dart';

part 'product_category_dto.g.dart';

@JsonSerializable()
class ProductCategoryDto {
  final int id;
  final String category;

  ProductCategoryDto(this.id, this.category);

  factory ProductCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryDtoToJson(this);
}