import 'package:caldo_cana_campeao/commons/network/network_constants.dart';
import 'package:caldo_cana_campeao/commons/sharedpreferences/campeao_shared_preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampeaoSharedPreferences {
  static CampeaoSharedPreferences? _storageUtil;
  static SharedPreferences? _sharedPreferences;

  static Future<CampeaoSharedPreferences> getInstance() async {
    if (_storageUtil == null) {
      var secureStorage = CampeaoSharedPreferences._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil!;
  }

  CampeaoSharedPreferences._();

  Future _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static void setUserToken(String token) {
    _sharedPreferences?.setString(
        CampeaoSharedPreferencesConstants.userToken, token);
  }

  static String? getUserToken() {
    return _sharedPreferences
        ?.getString(CampeaoSharedPreferencesConstants.userToken);
  }

  static void setUserName(String name) {
    _sharedPreferences?.setString(
        CampeaoSharedPreferencesConstants.userName, name);
  }

  static String? getUserName() {
    return _sharedPreferences
        ?.getString(CampeaoSharedPreferencesConstants.userName);
  }

  static void setUserId(int id) {
    _sharedPreferences?.setInt(CampeaoSharedPreferencesConstants.userId, id);
  }

  static int? getUserId() {
    return _sharedPreferences?.getInt(CampeaoSharedPreferencesConstants.userId);
  }

  static void setUserEmail(String email) {
    _sharedPreferences?.setString(
        CampeaoSharedPreferencesConstants.userEmail, email);
  }

  static String? getUserEmail() {
    return _sharedPreferences
        ?.getString(CampeaoSharedPreferencesConstants.userEmail);
  }

  static void setUserIsAdmin(bool isAdmin) {
    _sharedPreferences?.setBool(
        CampeaoSharedPreferencesConstants.userIsAdmin, isAdmin);
  }

  static bool? getUserIsAdmin() {
    return _sharedPreferences
        ?.getBool(CampeaoSharedPreferencesConstants.userIsAdmin);
  }

  static void clearLogonInfos() {
    _sharedPreferences?.remove(CampeaoSharedPreferencesConstants.userToken);
    _sharedPreferences?.remove(CampeaoSharedPreferencesConstants.userName);
    _sharedPreferences?.remove(CampeaoSharedPreferencesConstants.userId);
    _sharedPreferences?.remove(CampeaoSharedPreferencesConstants.userIsAdmin);
    _sharedPreferences?.remove(CampeaoSharedPreferencesConstants.userEmail);
    CampeaoNetworkConstants.removeAuthorizationHeader();
  }

  static void saveLogonInfos(
    int id,
    String token,
    String email,
    String name,
    bool isAdmin,
  ) {
    CampeaoSharedPreferences.setUserId(id);
    CampeaoSharedPreferences.setUserToken(token);
    CampeaoSharedPreferences.setUserEmail(email);
    CampeaoSharedPreferences.setUserName(name);
    CampeaoSharedPreferences.setUserIsAdmin(isAdmin);
  }
}
