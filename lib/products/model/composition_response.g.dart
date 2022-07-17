// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'composition_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompositionResponse _$CompositionResponseFromJson(Map<String, dynamic> json) =>
    CompositionResponse(
      json['id'] as int,
      json['name'] as String,
      (json['qtt'] as num).toDouble(),
      (json['costValue'] as num).toDouble(),
      (json['saleValue'] as num).toDouble(),
      json['groupType'] as String,
      json['category'] as String,
      json['unMeasure'] as String,
    );

Map<String, dynamic> _$CompositionResponseToJson(
        CompositionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'qtt': instance.qtt,
      'costValue': instance.costValue,
      'saleValue': instance.saleValue,
      'groupType': instance.groupType,
      'category': instance.category,
      'unMeasure': instance.unMeasure,
    };
