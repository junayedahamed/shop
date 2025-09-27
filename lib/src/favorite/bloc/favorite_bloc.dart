import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ocad/src/database/apis/api_calls.dart';
import 'package:ocad/src/database/demo_data.dart';
import 'package:ocad/src/product_model/product_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  // final RuntimeData runtimeData = RuntimeData();
  FavoriteBloc() : super(FavoriteInitial()) {
    on<RemoveFromFavEvent>(removeFromFavEvent);
    on<FavoriteDataInitialEvent>(favoriteDataInitialEvent);
  }

  FutureOr<void> removeFromFavEvent(
    RemoveFromFavEvent event,
    Emitter<FavoriteState> emit,
  ) {
    // log(event.index.toString());
    favorite.remove(event.index);
    emit(RemoveFromFavState());
    emit(FavoriteRemovedMessageState());
  }

  FutureOr<void> favoriteDataInitialEvent(
    FavoriteDataInitialEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      log("here${favorite.isEmpty}");
      if (favorite.isEmpty) {
        emit(FavoriteInitialDataLoadingSate());
        final favDatas = await ApiCalls.getItemFromFavorite("useremailapp");
        favorite.addAll(favDatas);
        log(favorite.toString());
        emit(FavoriteInitialDataLoadedSate());
      } else {
        emit(FavoriteInitialDataLoadedSate());
      }
    } catch (e) {
      emit(FavoriteInitialDataLoadErrorSate(errormessage: e.toString()));
    }
  }
}
