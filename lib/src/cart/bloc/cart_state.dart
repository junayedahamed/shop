part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartActionState extends CartState {}

final class RemovedFromCartMsgState extends CartActionState {}

// final class RemovedFromCartState extends CartState {}

final class CartLoadingState extends CartState {}

final class CartDataLoadedState extends CartState {
  final List<ProductDataModel> cartData;

  CartDataLoadedState({required this.cartData});
}

final class CartDataLoadErrorState extends CartState {}

final class CartLoadErrorMsgState extends CartActionState {
  final String errormessage;

  CartLoadErrorMsgState({required this.errormessage});
}
