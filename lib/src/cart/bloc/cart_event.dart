part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class RemoveFromCartEvent extends CartEvent {
  final int index;

  RemoveFromCartEvent({required this.index});
}
