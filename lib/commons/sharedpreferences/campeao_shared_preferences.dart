import 'package:caldo_cana_campeao/commons/sharedpreferences/campeao_shared_preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampeaoSharedPreferences {
  static void setUserToken(String token) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        CampeaoSharedPreferencesConstants.userToken, token);
  }

  static Future<String?> getUserToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences
        .getString(CampeaoSharedPreferencesConstants.userToken);
  }

  static void setUserName(String name) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        CampeaoSharedPreferencesConstants.userName, name);
  }

  static Future<String?> getUserName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences
        .getString(CampeaoSharedPreferencesConstants.userName);
  }

  static void setUserId(int id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setInt(
        CampeaoSharedPreferencesConstants.userId, id);
  }

  static Future<int?> getUserId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getInt(CampeaoSharedPreferencesConstants.userId);
  }

  static void setUserEmail(String email) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        CampeaoSharedPreferencesConstants.userEmail, email);
  }

  static Future<int?> getUserEmail() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences
        .getInt(CampeaoSharedPreferencesConstants.userEmail);
  }

  static void setUserIsAdmin(bool isAdmin) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setBool(
        CampeaoSharedPreferencesConstants.userIsAdmin, isAdmin);
  }

  static Future<int?> getUserIsAdmin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences
        .getInt(CampeaoSharedPreferencesConstants.userIsAdmin);
  }
}
