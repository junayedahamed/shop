import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:ocad/src/database/apis/api_calls.dart';
import 'package:ocad/src/database/demo_data.dart';
import 'package:ocad/src/model/product_model/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ApiCalls apiCalls = ApiCalls();
  CartBloc() : super(CartInitial()) {
    on<RemoveFromCartEvent>(removeFromCartEvent);
    on<CartInitialEvent>(cartInitialEvent);
  }

  FutureOr<void> removeFromCartEvent(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) {
    cart.removeAt(event.index);
    // emit(RemovedFromCartState());
    // emit(RemovedFromCartMsgState());
  }

  FutureOr<void> cartInitialEvent(
    CartInitialEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      if (cart.isEmpty) {
        emit(CartLoadingState());
        final result = await apiCalls.getCartItems(
          dotenv.env['USER_EMAIL'].toString(),
        );
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
