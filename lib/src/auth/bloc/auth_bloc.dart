import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:ocad/src/database/apis/api_calls.dart';
import 'package:ocad/src/models/user_model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiCalls apiCalls = ApiCalls();
  AuthBloc() : super(AuthInitial()) {
    // on<AuthEvent>((event, emit) {});

    on<ShowPasswordEventLogin>(showPasswordEventLogin);

    on<ShowPasswordEventRegistration>(showPasswordEventRegistration);
    on<LoginUserEvent>(loginUserEvent);
  }

  /// Show Password Event for Login
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

  //registration passsword show hide
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

  FutureOr<void> loginUserEvent(
    LoginUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      log({event.email, event.password}.toString());
      emit(LoginLoadingState());
      final user = await apiCalls.loginUser(event.email, event.password);
      if (user.user == null) {
        emit(LoginFailureState(error: user.message ?? "Login failed"));
        emit(LoginFailState());
        // return;
      } else {
        emit(LoginSuccessState(user: user.user));
        log("going to home page");
      }
    } catch (e) {
      log("here");
      emit(LoginFailureState(error: e.toString()));

      emit(LoginFailState());
    }
  }
}
