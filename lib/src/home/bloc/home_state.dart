part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeActionState extends HomeState {}

final class AddToFavourite extends HomeActionState {}

final class AddToCart extends HomeActionState {}
