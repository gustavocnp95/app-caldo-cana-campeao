// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      json['id'] as int,
      json['name'] as String,
      (json['qtt'] as num).toDouble(),
      (json['costValue'] as num?)?.toDouble(),
      (json['saleValue'] as num).toDouble(),
      json['groupType'] as String,
      ProductCategoryDto.fromJson(json['category'] as Map<String, dynamic>),
      json['unMeasure'] as String,
      (json['itemsCompositions'] as List<dynamic>)
          .map((e) => CompositionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'qtt': instance.qtt,
      'costValue': instance.costValue,
      'saleValue': instance.saleValue,
      'groupType': instance.groupType,
      'category': instance.category,
      'unMeasure': instance.unMeasure,
      'itemsCompositions': instance.itemsCompositions,
    };
