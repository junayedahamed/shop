import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<ShowPasswordEventLogin>(showPasswordEventLogin);

    on<ShowPasswordEventRegistration>(showPasswordEventRegistration);
  }

  FutureOr<void> showPasswordEventLogin(
    ShowPasswordEventLogin event,
    Emitter<AuthState> emit,
  ) {
    if (state is ShowPasswordStateLogin) {
      final curr = state as ShowPasswordStateLogin;
      emit(ShowPasswordStateLogin(isShow: !curr.isShow));
    } else {
      emit(ShowPasswordStateLogin(isShow: true));
    }
  }

  FutureOr<void> showPasswordEventRegistration(
    ShowPasswordEventRegistration event,
    Emitter<AuthState> emit,
  ) {
    if (state is ShowPasswordStateRegistration) {
      final curr = state as ShowPasswordStateRegistration;
      emit(ShowPasswordStateRegistration(isShow: !curr.isShow));
    } else {
      emit(ShowPasswordStateRegistration(isShow: true));
    }
  }
}
