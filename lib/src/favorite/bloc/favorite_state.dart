part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteActionState extends FavoriteState {}

final class FavoriteRemovedMessageState extends FavoriteActionState {}

final class RemoveFromFavState extends FavoriteState {}
