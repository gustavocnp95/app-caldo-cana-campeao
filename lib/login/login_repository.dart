import 'package:caldo_cana_campeao/login/login_rest.dart';
import 'package:caldo_cana_campeao/login/model/login_request.dart';

import 'model/token_response.dart';

class LoginRepository {
  final LoginRest _loginRest = LoginRest();

  Future<TokenResponse> doLogin(LoginRequest loginRequest) {
    return _loginRest.doLogin(loginRequest);
  }
}
