import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ocad/src/database/demo_data.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  // final RuntimeData runtimeData = RuntimeData();
  CartBloc() : super(CartInitial()) {
    on<RemoveFromCartEvent>(removeFromCartEvent);
  }

  FutureOr<void> removeFromCartEvent(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) {
    cart.removeAt(event.index);
    emit(RemovedFromCartState());
    emit(RemovedFromCartMsgState());
  }
}
