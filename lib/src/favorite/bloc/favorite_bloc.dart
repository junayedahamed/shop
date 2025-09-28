import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:ocad/src/database/apis/api_calls.dart';
import 'package:ocad/src/database/demo_data.dart';
import 'package:ocad/src/model/product_model/product_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<RemoveFromFavEvent>(removeFromFavEvent);
    on<FavoriteDataInitialEvent>(favoriteDataInitialEvent);
  }
  final ApiCalls apiCalls = ApiCalls();

  FutureOr<void> removeFromFavEvent(
    RemoveFromFavEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    log(event.item.toString());
    try {
      final result = await apiCalls.rmoveItemFromFavorite(
        dotenv.env['USER_EMAIL'].toString(),
        event.item.id,
      );
      favorite.remove(event.item);

      emit(FavoriteInitialDataLoadedSate(productData: favorite));

      emit(FavoriteRemovedMessageState(removedMessage: result));
    } catch (e) {
      log(e.toString());
      emit(FavoriteRemoveErrorState(message: e.toString()));
    }
  }

  FutureOr<void> favoriteDataInitialEvent(
    FavoriteDataInitialEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      // log("here${favorite.isEmpty}");
      if (favorite.isEmpty) {
        emit(FavoriteInitialDataLoadingSate());
        final favDatas = await apiCalls.getItemFromFavorite("useremailapp");
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
