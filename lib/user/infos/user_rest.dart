import 'dart:convert';

import 'package:caldo_cana_campeao/user/infos/model/user_update_dto.dart';
import 'package:http/http.dart' as http;

import '../../commons/network/network_constants.dart';
import 'model/user_response.dart';

class UserRest {
  Future<UserResponse> updateUser(UserUpdateDto loginRequest) async {
    final response = await http.put(
      Uri.parse(CampeaoNetworkConstants.wsUrl + "users"),
      headers: CampeaoNetworkConstants.headers,
      body: jsonEncode(loginRequest.toJson()),
    );
    if (response.statusCode == CampeaoNetworkConstants.statusOk) {
      return UserResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("teste");
    }
  }
}