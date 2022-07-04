import 'package:json_annotation/json_annotation.dart';

import 'composition_response.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  final int id;
  final String name;
  final double qtt;
  final double costValue;
  final double saleValue;
  final String groupType;
  final String category;
  final String unMeasure;
  final List<CompositionResponse> itemsCompositions;

  ProductResponse(this.id, this.name, this.qtt, this.costValue, this.saleValue,
      this.groupType, this.category, this.unMeasure, this.itemsCompositions);

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
