part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthActionState extends AuthState {}

final class ShowPasswordStateLogin extends AuthState {
  final bool isShow;
  ShowPasswordStateLogin({required this.isShow});
}

final class ShowPasswordStateRegistration extends AuthState {
  final bool isShow;
  ShowPasswordStateRegistration({required this.isShow});
}

final class LoginLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {
  final UserModel? user;
  LoginSuccessState({this.user});
}

final class LoginFailState extends AuthState {}

final class LoginFailureState extends AuthActionState {
  final String error;
  LoginFailureState({required this.error});
}

final class RegistrationSuccessState extends AuthState {}

final class RegistrationFailureState extends AuthActionState {
  final String error;
  RegistrationFailureState({required this.error});
}

final class RegistrationLoadingState extends AuthState {}
