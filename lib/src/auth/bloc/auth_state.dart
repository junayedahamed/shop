part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class ShowPasswordStateLogin extends AuthState {
  final bool isShow;
  ShowPasswordStateLogin({required this.isShow});
}

final class ShowPasswordStateRegistration extends AuthState {
  final bool isShow;
  ShowPasswordStateRegistration({required this.isShow});
}
