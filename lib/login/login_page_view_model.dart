import 'dart:async';

import 'package:caldo_cana_campeao/login/login_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../commons/sharedpreferences/campeao_shared_preferences.dart';
import 'model/login_request.dart';
import 'model/token_response.dart';

class LoginPageViewModel extends ChangeNotifier {
  final LoginRepository _loginRepository = LoginRepository();
  bool _doingAsyncOperation = false;
  bool _errorHapenned = false;
  TokenResponse? _tokenResponse;

  TokenResponse? get tokenResponse => _tokenResponse;

  bool get doingAsyncOperation => _doingAsyncOperation;

  void doLogin(String email, String password, Function afterLogin) {
    _setDoingAsyncOperation(true);
    _loginRepository
        .doLogin(LoginRequest(email, password))
        .then((userInfos) => _onLoginSuccess(userInfos, afterLogin))
        .whenComplete(() => _setDoingAsyncOperation(false));
  }

  void _onLoginSuccess(TokenResponse userInfos, Function afterLogin) {
    _tokenResponse = userInfos;
    saveUserInfos(userInfos);
    afterLogin();
  }

  void saveUserInfos(TokenResponse userInfos) {
    CampeaoSharedPreferences.setUserId(userInfos.userId);
    CampeaoSharedPreferences.setUserToken(userInfos.token);
    CampeaoSharedPreferences.setUserEmail(userInfos.email);
    CampeaoSharedPreferences.setUserName(userInfos.userName);
    CampeaoSharedPreferences.setUserIsAdmin(userInfos.isAdmin);
  }

  void _setDoingAsyncOperation(bool doingAsyncOperation) {
    _doingAsyncOperation = doingAsyncOperation;
    notifyListeners();
  }
}
