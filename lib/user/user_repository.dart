import 'package:caldo_cana_campeao/user/infos/model/user_response.dart';
import 'package:caldo_cana_campeao/user/infos/model/user_update_dto.dart';
import 'package:caldo_cana_campeao/user/user_rest.dart';

class UserRepository {
  final UserRest _userRest = UserRest();

  Future<UserResponse> updateUser(UserUpdateDto userUpdateDto) {
    return _userRest.updateUser(userUpdateDto);
  }

  Future<List<UserResponse>> getAll() {
    return _userRest.getAll();
  }
}
