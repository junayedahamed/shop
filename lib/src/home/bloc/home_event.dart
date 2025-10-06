part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class AllDataInitialEvent extends HomeEvent {}

final class OnrefreshEvent extends HomeEvent {}

final class AddToFavouriteEvent extends HomeEvent {
  final ProductDataModel data;
  final BuildContext context;
  AddToFavouriteEvent({required this.data, required this.context});
}

final class AddToCartEvent extends HomeEvent {
  final ProductDataModel data;
  final BuildContext context;
  AddToCartEvent({required this.data, required this.context});
}
