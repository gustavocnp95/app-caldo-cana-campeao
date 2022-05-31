import 'package:flutter/foundation.dart';

class UserVisualizationEditionPageViewModel extends ChangeNotifier {
  bool _doingAsyncOperation = false;

  bool get doingAsyncOperation => _doingAsyncOperation;

  void updateUser(String userId, String email, String name, bool isAdmin) {

  }
}
