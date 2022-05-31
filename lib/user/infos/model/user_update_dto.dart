import 'package:json_annotation/json_annotation.dart';

part 'user_update_dto.g.dart';

@JsonSerializable()
class UserUpdateDto {
  final int id;
  final String name;
  final String email;
  final String? password;
  final bool isAdmin;


  UserUpdateDto(this.id, this.name, this.email, this.password, this.isAdmin);

  factory UserUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateDtoToJson(this);
}
