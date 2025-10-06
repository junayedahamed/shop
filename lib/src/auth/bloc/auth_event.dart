part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class ShowPasswordEventLogin extends AuthEvent {}

final class ShowPasswordEventRegistration extends AuthEvent {}

final class ShowConfirmPasswordEventRegistration extends AuthEvent {}

final class LoginUserEvent extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  LoginUserEvent({
    required this.email,
    required this.password,
    required this.context,
  });
}

final class RegisterUserEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final BuildContext context;

  RegisterUserEvent({
    required this.context,
    required this.name,
    required this.email,
    required this.password,
  });
}
