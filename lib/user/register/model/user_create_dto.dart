import 'package:json_annotation/json_annotation.dart';

part 'user_create_dto.g.dart';

@JsonSerializable()
class UserCreateDto {
  final String name;
  final String email;
  final String password;
  final bool isAdmin;

  UserCreateDto(this.name, this.email, this.password, this.isAdmin);

  factory UserCreateDto.fromJson(Map<String, dynamic> json) =>
      _$UserCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreateDtoToJson(this);
}