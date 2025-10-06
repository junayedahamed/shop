import 'package:ocad/src/models/user_model/user_model.dart';

class LoginResult {
  final UserModel? user;
  final String? message;

  bool get isSuccess => user != null;

  LoginResult({this.user, this.message});
}
