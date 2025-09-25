part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {
  // final List<ProductDataModel> data;

  // FavoriteInitial({required this.data});
}

final class FavoriteActionState extends FavoriteState {}

final class FavoriteRemovedMessageState extends FavoriteActionState {}

final class RemoveFromFavState extends FavoriteState {}
