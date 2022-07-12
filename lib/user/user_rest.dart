import 'package:caldo_cana_campeao/commons/campeao_json.dart';
import 'package:caldo_cana_campeao/user/infos/model/user_update_dto.dart';
import 'package:caldo_cana_campeao/user/register/model/user_create_dto.dart';
import 'package:http/http.dart' as http;

import '../commons/network/network_constants.dart';
import 'infos/model/user_response.dart';

class UserRest {
  Future<UserResponse> updateUser(UserUpdateDto userUpdateDto) async {
    final response = await http.put(
      Uri.parse(CampeaoNetworkConstants.wsUrl + "users"),
      headers: CampeaoNetworkConstants.headers,
      body: CampeaoJson.encode(userUpdateDto.toJson()),
    );
    if (response.statusCode == CampeaoNetworkConstants.statusOk) {
      return UserResponse.fromJson(CampeaoJson.decode(response.bodyBytes));
    } else {
      throw Exception("Error updating user");
    }
  }

  Future<List<UserResponse>> getAll() async {
    final response = await http.get(
      Uri.parse(CampeaoNetworkConstants.wsUrl + "users"),
      headers: CampeaoNetworkConstants.headers,
    );
    if (response.statusCode == CampeaoNetworkConstants.statusOk) {
      final Iterable l = CampeaoJson.decode(response.bodyBytes);
      return List<UserResponse>.from(
          l.map((userJson) => UserResponse.fromJson(userJson)));
    } else {
      throw Exception("Error when getting users");
    }
  }

  Future<bool> deleteUser(int userId) async {
    final response = await http.delete(
      Uri.parse(CampeaoNetworkConstants.wsUrl + "users/" + userId.toString()),
      headers: CampeaoNetworkConstants.headers,
    );
    if (response.statusCode != CampeaoNetworkConstants.statusOk) {
      throw Exception("Error when getting users");
    } else {
      return true;
    }
  }

  Future<UserResponse> createUser(UserCreateDto userCreateDto) async {
    final response = await http.post(
      Uri.parse(CampeaoNetworkConstants.wsUrl + "users"),
      headers: CampeaoNetworkConstants.headers,
      body: CampeaoJson.encode(userCreateDto.toJson()),
    );
    if (response.statusCode == CampeaoNetworkConstants.statusOk) {
      return UserResponse.fromJson(CampeaoJson.decode(response.bodyBytes));
    } else {
      throw Exception("Error creating user");
    }
  }
}
