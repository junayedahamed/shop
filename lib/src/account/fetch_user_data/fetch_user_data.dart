
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ocad/src/auth/save_user_data/session_manager.dart';
import 'package:ocad/src/database/apis/api_calls.dart';
import 'package:ocad/src/models/user_model/user_model.dart';

class FetchUserData extends ChangeNotifier {
  final SessionManager sessionManager = SessionManager();
  final ApiCalls apiCalls = ApiCalls();
  UserModel? _user;

  UserModel? get user => _user;
  void getUser() async {
    _user = await sessionManager.getUser();

    notifyListeners();
  }

  void clearUser(BuildContext context) async {
    await sessionManager.clearSession();
    if (context.mounted) {
      context.go('/login');
      _user = null;
    }
    notifyListeners();
  }
}
