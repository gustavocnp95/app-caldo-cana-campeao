// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdateDto _$UserUpdateDtoFromJson(Map<String, dynamic> json) =>
    UserUpdateDto(
      json['id'] as int,
      json['name'] as String,
      json['email'] as String,
      json['password'] as String?,
      json['isAdmin'] as bool,
    );

Map<String, dynamic> _$UserUpdateDtoToJson(UserUpdateDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'isAdmin': instance.isAdmin,
    };
