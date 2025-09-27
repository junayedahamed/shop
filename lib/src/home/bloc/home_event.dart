part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class FoodInitialEvent extends HomeEvent {}

final class OnrefreshEvent extends HomeEvent {}

final class AddToFavouriteEvent extends HomeEvent {
  final ProductDataModel data;
  AddToFavouriteEvent({required this.data});
}

final class AddToCartEvent extends HomeEvent {
  final ProductDataModel data;
  AddToCartEvent({required this.data});
}
