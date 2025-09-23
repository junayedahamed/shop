part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

final class RemoveFromFavEvent extends FavoriteEvent {
  final int index;

  RemoveFromFavEvent({required this.index});
}
