import 'package:caldo_cana_campeao/user/infos/model/user_response.dart';
import 'package:caldo_cana_campeao/user/infos/model/user_update_dto.dart';
import 'package:caldo_cana_campeao/user/infos/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserVisualizationEditionPageViewModel extends ChangeNotifier {
  final UserRepository _repository = UserRepository();
  bool _doingAsyncOperation = false;

  bool get doingAsyncOperation => _doingAsyncOperation;

  void updateUser(
    int userId,
    String email,
    String name,
    String? password,
    bool isAdmin,
    Function onSuccess,
    Function onError,
  ) {
    _setDoingAsyncOperation(true);
    _repository
        .updateUser(UserUpdateDto(userId, name, email, password, isAdmin))
        .catchError((error, stackTrace) {
          _onUpdateUserError(error, onError);
        })
        .then((userUpdated) => _onUpdateUserSuccess)
        .whenComplete(() => _setDoingAsyncOperation(false));
  }

  void _onUpdateUserSuccess(
    UserResponse userResponse,
    Function onSucessCallback,
  ) {
    onSucessCallback();
  }

  void _onUpdateUserError(Exception e, Function onErrorCallback) {
    onErrorCallback();
  }

  void _setDoingAsyncOperation(bool doingAsyncOperation) {
    _doingAsyncOperation = doingAsyncOperation;
    notifyListeners();
  }
}
