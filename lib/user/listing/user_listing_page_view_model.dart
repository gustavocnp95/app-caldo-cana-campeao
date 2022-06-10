import 'package:caldo_cana_campeao/user/user_repository.dart';
import 'package:flutter/material.dart';

import '../infos/model/user_response.dart';

class UserListingPageViewModel extends ChangeNotifier {
  final UserRepository _repository = UserRepository();
  bool _doingAsyncOperation = false;
  List<UserResponse> users = List.empty();

  bool get doingAsyncOperation => _doingAsyncOperation;

  void deleteUser(int userId, Function onSuccess, Function onError) {
    _setDoingAsyncOperation(true);
    _repository
        .deleteUser(userId)
        .catchError((error, stackTrace) {
          _onDeleteUserError(error, onError);
        })
        .then((_) => _onDeleteUserSuccess(userId, onSuccess))
        .whenComplete(() => _setDoingAsyncOperation(false));
  }

  void _onDeleteUserSuccess(
    int userId,
    Function onSucessCallback,
  ) {
    users.removeWhere((element) => element.id == userId);
    notifyListeners();
    onSucessCallback();
  }

  void _onDeleteUserError(Exception e, Function onErrorCallback) {
    onErrorCallback();
  }

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
