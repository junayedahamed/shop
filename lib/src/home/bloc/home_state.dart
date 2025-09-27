part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class FoodLoadingState extends HomeState {}

final class FoodLoadFailedState extends HomeState {
  final String errorMessage;

  FoodLoadFailedState({required this.errorMessage});
}

final class FoodLoadedState extends HomeState {
  final List<ProductDataModel> data;

  FoodLoadedState({required this.data});
}

final class HomeActionState extends HomeState {}

final class AddedToFavouriteState extends HomeActionState {
  final String message;

  AddedToFavouriteState({required this.message});
}

final class AddedToCartState extends HomeActionState {}
