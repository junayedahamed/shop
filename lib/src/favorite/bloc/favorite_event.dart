part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

final class RemoveFromFavEvent extends FavoriteEvent {
  final ProductDataModel index;

  RemoveFromFavEvent({required this.index});
}

final class FavoriteDataInitialEvent extends FavoriteEvent {}
