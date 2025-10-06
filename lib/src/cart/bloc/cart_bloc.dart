import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:ocad/src/auth/save_user_data/session_manager.dart';
import 'package:ocad/src/database/apis/api_calls.dart';
import 'package:ocad/src/database/demo_data.dart';
import 'package:ocad/src/models/product_model/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ApiCalls apiCalls = ApiCalls();
  CartBloc() : super(CartInitial()) {
    on<RemoveFromCartEvent>(removeFromCartEvent);
    on<CartInitialEvent>(cartInitialEvent);
  }
  final SessionManager sessionManager = SessionManager();

  FutureOr<void> removeFromCartEvent(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      final user = await sessionManager.getUser();
      if (user?.email == null || user == null) {
        emit(
          RemovedErrorCartMsgState(removedFromCartMsg: "User not logged in"),
        );
        return;
      }
      final result = await apiCalls.rmoveItemFromCart(
        user.email,
        event.index.id,
      );
      cart.remove(event.index);

      emit(CartDataLoadedState(cartData: cart));
      emit(RemovedFromCartMsgState(removedFromCartMsg: result));
    } catch (e) {
      emit(RemovedErrorCartMsgState(removedFromCartMsg: e.toString()));
    }
  }

  FutureOr<void> cartInitialEvent(
    CartInitialEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      final user = await sessionManager.getUser();
      if (user?.email == null || user == null) {
        emit(CartDataLoadedState(cartData: cart));
        return;
      }

      if (cart.isEmpty) {
        emit(CartLoadingState());
        final result = await apiCalls.getCartItems(user.email);
        // log(result.isEmpty.toString());
        if (result.isNotEmpty) {
          cart.addAll(result);
        }
        emit(CartDataLoadedState(cartData: cart));
      } else {
        // log("no call");
        emit(CartDataLoadedState(cartData: cart));
      }
    } catch (e) {
      emit(CartDataLoadErrorState());
      emit(CartLoadErrorMsgState(errormessage: e.toString()));
    }
  }
}
