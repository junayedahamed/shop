part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class RemoveFromCartEvent extends CartEvent {
  final ProductDataModel index;

  RemoveFromCartEvent({required this.index});
}

final class CartInitialEvent extends CartEvent {}
