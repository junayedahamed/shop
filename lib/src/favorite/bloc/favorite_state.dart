part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteActionState extends FavoriteState {}

final class FavoriteRemovedMessageState extends FavoriteActionState {
  final String removedMessage;

  FavoriteRemovedMessageState({required this.removedMessage});
}

// final class RemoveFromFavState extends FavoriteState {}

final class FavoriteInitialDataLoadedSate extends FavoriteState {
  final List<ProductDataModel> productData;

  FavoriteInitialDataLoadedSate({required this.productData});
}

final class FavoriteInitialDataLoadingSate extends FavoriteState {}

final class FavoriteInitialDataLoadErrorSate extends FavoriteState {
  final String errormessage;

  FavoriteInitialDataLoadErrorSate({required this.errormessage});
}

final class FavoriteRemoveErrorState extends FavoriteActionState {
  final String message;

  FavoriteRemoveErrorState({required this.message});
}
