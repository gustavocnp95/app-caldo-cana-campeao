import 'package:json_annotation/json_annotation.dart';

part 'composition_response.g.dart';

@JsonSerializable()
class CompositionResponse {
  final int id;
  final String name;
  final double qtt;
  final double? costValue;
  final double? saleValue;
  final String groupType;
  final String category;
  final String unMeasure;

  CompositionResponse(this.id, this.name, this.qtt, this.costValue,
      this.saleValue, this.groupType, this.category, this.unMeasure);

  factory CompositionResponse.fromJson(Map<String, dynamic> json) =>
      _$CompositionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CompositionResponseToJson(this);
}
