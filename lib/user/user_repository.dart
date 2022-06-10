import 'package:caldo_cana_campeao/user/infos/model/user_response.dart';
import 'package:caldo_cana_campeao/user/infos/model/user_update_dto.dart';
import 'package:caldo_cana_campeao/user/register/model/user_create_dto.dart';
import 'package:caldo_cana_campeao/user/user_rest.dart';

class UserRepository {
  final UserRest _userRest = UserRest();

  Future<UserResponse> updateUser(UserUpdateDto userUpdateDto) {
    return _userRest.updateUser(userUpdateDto);
  }

  Future<UserResponse> createUser(UserCreateDto userCreateDto) {
    return _userRest.createUser(userCreateDto);
  }

  Future<List<UserResponse>> getAll() {
    return _userRest.getAll();
  }

  Future<bool> deleteUser(int userId) {
    return _userRest.deleteUser(userId);
  }
}
