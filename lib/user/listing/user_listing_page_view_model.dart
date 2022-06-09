import 'package:caldo_cana_campeao/user/user_repository.dart';
import 'package:flutter/material.dart';

import '../infos/model/user_response.dart';

class UserListingPageViewModel extends ChangeNotifier {
  final UserRepository _repository = UserRepository();
  bool _doingAsyncOperation = false;
  List<UserResponse> users = List.empty();

  bool get doingAsyncOperation => _doingAsyncOperation;

  void fetchUsers(
    Function onSuccess,
    Function onError,
  ) {
    _setDoingAsyncOperation(true);
    _repository
        .getAll()
        .catchError((error, stackTrace) {
          _onFetchUserError(error, onError);
        })
        .then((usersResponse) => _onFetchUserSuccess(usersResponse, onSuccess))
        .whenComplete(() => _setDoingAsyncOperation(false));
  }

  void _onFetchUserSuccess(
    List<UserResponse> usersResponse,
    Function onSucessCallback,
  ) {
     users = usersResponse;
    notifyListeners();
    onSucessCallback();
  }

  void _onFetchUserError(Exception e, Function onErrorCallback) {
    onErrorCallback();
  }

  void _setDoingAsyncOperation(bool doingAsyncOperation) {
    _doingAsyncOperation = doingAsyncOperation;
    notifyListeners();
  }
}
