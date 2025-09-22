part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class FoodInitialEvent extends HomeEvent {}

final class AddToFavouriteEvent extends HomeEvent {}

final class AddToCartEvent extends HomeEvent {}
