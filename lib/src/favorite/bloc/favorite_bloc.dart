import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ocad/src/auth/save_user_data/session_manager.dart';
import 'package:ocad/src/database/apis/api_calls.dart';
import 'package:ocad/src/database/demo_data.dart';
import 'package:ocad/src/models/product_model/product_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<RemoveFromFavEvent>(removeFromFavEvent);
    on<FavoriteDataInitialEvent>(favoriteDataInitialEvent);
  }
  final ApiCalls apiCalls = ApiCalls();
  final SessionManager sessionManager = SessionManager();

  FutureOr<void> removeFromFavEvent(
    RemoveFromFavEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    // log(event.item.toString());
    try {
      final user = await sessionManager.getUser();
      if (user?.email == null || user == null) {
        emit(FavoriteRemoveErrorState(message: "User not logged in"));
        return;
      }
      final result = await apiCalls.rmoveItemFromFavorite(
        user.email,
        event.item.id,
      );
      favorite.remove(event.item);

      emit(FavoriteInitialDataLoadedSate(productData: favorite));

      emit(FavoriteRemovedMessageState(removedMessage: result));
    } catch (e) {
      // log(e.toString());
      emit(FavoriteRemoveErrorState(message: e.toString()));
    }
  }

  FutureOr<void> favoriteDataInitialEvent(
    FavoriteDataInitialEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      final user = await sessionManager.getUser();
      if (user?.email == null || user == null) {
        emit(FavoriteInitialDataLoadedSate(productData: favorite));
        return;
      }
      // log("here${favorite.isEmpty}");
      if (favorite.isEmpty) {
        // log(dotenv.env['GET_ITEM_FAV'].toString());
        emit(FavoriteInitialDataLoadingSate());
        final favDatas = await apiCalls.getItemFromFavorite(user.email);
        favorite.addAll(favDatas);
        // log(favorite.toString());
        emit(FavoriteInitialDataLoadedSate(productData: favorite));
      } else {
        emit(FavoriteInitialDataLoadedSate(productData: favorite));
      }
    } catch (e) {
      emit(FavoriteInitialDataLoadErrorSate(errormessage: e.toString()));
    }
  }
}
