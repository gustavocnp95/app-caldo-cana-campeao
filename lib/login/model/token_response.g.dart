// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) =>
    TokenResponse(
      json['token'] as String,
      json['tokenType'] as String,
      json['userId'] as int,
      json['userName'] as String,
      json['email'] as String,
      json['isAdmin'] as bool,
    );

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'tokenType': instance.tokenType,
      'userId': instance.userId,
      'userName': instance.userName,
      'email': instance.email,
      'isAdmin': instance.isAdmin,
    };
