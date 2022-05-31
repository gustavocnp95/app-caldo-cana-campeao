import 'package:caldo_cana_campeao/user/infos/model/user_response.dart';
import 'package:caldo_cana_campeao/user/infos/model/user_update_dto.dart';
import 'package:caldo_cana_campeao/user/infos/user_repository.dart';
import 'package:flutter/foundation.dart';

class UserVisualizationEditionPageViewModel extends ChangeNotifier {
  final UserRepository _repository = UserRepository();
  bool _doingAsyncOperation = false;

  bool get doingAsyncOperation => _doingAsyncOperation;

  void updateUser(int userId,
      String email,
      String name,
      String? password,
      bool isAdmin) {
    _setDoingAsyncOperation(true);
    _repository
        .updateUser(UserUpdateDto(userId, name, email, password, isAdmin))
        .then((userUpdated) => _onUpdateUserSuccess)
        .whenComplete(() => _setDoingAsyncOperation(false));
  }
  
  void _onUpdateUserSuccess(UserResponse userResponse) {

  }

  void _setDoingAsyncOperation(bool doingAsyncOperation) {
    _doingAsyncOperation = doingAsyncOperation;
    notifyListeners();
  }
}
