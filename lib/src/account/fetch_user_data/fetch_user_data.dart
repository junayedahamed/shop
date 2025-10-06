import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ocad/src/auth/save_user_data/session_manager.dart';
import 'package:ocad/src/models/user_model/user_model.dart';

class FetchUserData extends ChangeNotifier {
  final SessionManager sessionManager = SessionManager();
  UserModel? _user;

  UserModel? get user => _user;
  void getUser() async {
    _user = await sessionManager.getUser();
    // log(_user.toString());
    // log(user?.email ?? "No email");
    // log(user?.name ?? "No name");
    // log(user?.createdAt.toString() ?? "No createdAt");
    notifyListeners();
  }
}
