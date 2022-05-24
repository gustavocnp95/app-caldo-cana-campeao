import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse {
  final String token;
  final String tokenType;
  final int userId;
  final String userName;
  final String email;
  final bool isAdmin;

  TokenResponse(
    this.token,
    this.tokenType,
    this.userId,
    this.userName,
    this.email,
    this.isAdmin,
  );

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}
