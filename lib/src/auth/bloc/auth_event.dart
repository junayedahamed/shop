part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class ShowPasswordEventLogin extends AuthEvent {}

final class ShowPasswordEventRegistration extends AuthEvent {}
