// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreateDto _$UserCreateDtoFromJson(Map<String, dynamic> json) =>
    UserCreateDto(
      json['name'] as String,
      json['email'] as String,
      json['password'] as String,
      json['isAdmin'] as bool,
    );

Map<String, dynamic> _$UserCreateDtoToJson(UserCreateDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'isAdmin': instance.isAdmin,
    };
