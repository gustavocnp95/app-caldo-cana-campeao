import 'dart:convert';

import 'package:caldo_cana_campeao/commons/network/network_constants.dart';
import 'package:caldo_cana_campeao/login/model/token_response.dart';
import 'package:http/http.dart' as http;

import '../commons/campeao_json.dart';
import 'model/login_request.dart';

class LoginRest {
  Future<TokenResponse> doLogin(LoginRequest loginRequest) async {
    final response = await http.post(
      Uri.parse(CampeaoNetworkConstants.wsUrl + "login"),
      headers: CampeaoNetworkConstants.headers,
      body: jsonEncode(loginRequest.toJson()),
    );
    if (response.statusCode == CampeaoNetworkConstants.statusOk) {
      return TokenResponse.fromJson(CampeaoJson.decode(response.bodyBytes));
    } else {
      throw Exception("teste");
    }
  }
}
