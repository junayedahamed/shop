part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartActionState extends CartState {}

final class RemovedFromCartMsgState extends CartActionState {}

final class RemovedFromCartState extends CartState {}

// final class AddedToCartState extends CartState {}

// final class AddedToCartMsgState extends CartState {}
