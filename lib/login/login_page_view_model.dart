import 'package:caldo_cana_campeao/commons/network/network_constants.dart';
import 'package:caldo_cana_campeao/login/login_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../commons/sharedpreferences/campeao_shared_preferences.dart';
import 'model/login_request.dart';
import 'model/token_response.dart';

class LoginPageViewModel extends ChangeNotifier {
  final LoginRepository _loginRepository = LoginRepository();
  bool _doingAsyncOperation = false;
  TokenResponse? _tokenResponse;

  TokenResponse? get tokenResponse => _tokenResponse;

  bool get doingAsyncOperation => _doingAsyncOperation;

  void doLogin(
    String email,
    String password,
    Function afterLogin,
    Function onErrorCallback,
  ) {
    _setDoingAsyncOperation(true);
    _loginRepository
        .doLogin(LoginRequest(email, password))
        .catchError((error, stackTrace) {
          _onLoginError(error, onErrorCallback);
        })
        .then((userInfos) => _onLoginSuccess(userInfos, afterLogin))
        .whenComplete(() => _setDoingAsyncOperation(false));
  }

  void _onLoginSuccess(TokenResponse userInfos, Function afterLogin) {
    _tokenResponse = userInfos;
    saveUserInfos(userInfos);
    CampeaoNetworkConstants.addAuthorizationHeader(userInfos.token);
    afterLogin();
  }

  void _onLoginError(Exception e, Function onErrorCallback) {
    onErrorCallback();
  }

  void saveUserInfos(TokenResponse userInfos) {
    CampeaoSharedPreferences.saveLogonInfos(
      userInfos.userId,
      userInfos.token,
      userInfos.email,
      userInfos.userName,
      userInfos.isAdmin,
    );
  }

  void _setDoingAsyncOperation(bool doingAsyncOperation) {
    _doingAsyncOperation = doingAsyncOperation;
    notifyListeners();
  }
}
