import 'package:caldo_cana_campeao/user/infos/model/user_response.dart';
import 'package:caldo_cana_campeao/user/register/model/user_create_dto.dart';
import 'package:flutter/foundation.dart';

import '../user_repository.dart';

class UserRegisterPageViewModel extends ChangeNotifier {
  final UserRepository _repository = UserRepository();
  bool _doingAsyncOperation = false;

  bool get doingAsyncOperation => _doingAsyncOperation;

  void createUser(
    String userName,
    String userEmail,
    String userPassword,
    bool isAdmin,
    Function onSuccess,
    Function onError,
  ) {
    _setDoingAsyncOperation(true);
    _repository
        .createUser(UserCreateDto(userName, userEmail, userPassword, isAdmin))
        .catchError((error, stackTrace) {
      _onCreateUserError(error, onError);
        })
        .then((userResponse) => _onCreateUserSuccess(userResponse, onSuccess))
        .whenComplete(() => _setDoingAsyncOperation(false));
  }

  void _onCreateUserSuccess(
    UserResponse userResponse,
    Function onSucessCallback,
  ) {
    onSucessCallback();
  }

  void _onCreateUserError(Exception e, Function onErrorCallback) {
    onErrorCallback();
  }

  void _setDoingAsyncOperation(bool doingAsyncOperation) {
    _doingAsyncOperation = doingAsyncOperation;
    notifyListeners();
  }
}
