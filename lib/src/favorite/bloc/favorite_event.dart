part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

final class RemoveFromFavEvent extends FavoriteEvent {
  final ProductDataModel item;

  RemoveFromFavEvent({required this.item});
}

final class FavoriteDataInitialEvent extends FavoriteEvent {}
