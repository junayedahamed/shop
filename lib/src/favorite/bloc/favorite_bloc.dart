import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ocad/src/database/demo_data.dart';
import 'package:ocad/src/product_model/product_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  // final RuntimeData runtimeData = RuntimeData();
  FavoriteBloc() : super(FavoriteInitial()) {
    on<RemoveFromFavEvent>(removeFromFavEvent);
  }

  FutureOr<void> removeFromFavEvent(
    RemoveFromFavEvent event,
    Emitter<FavoriteState> emit,
  ) {
    log(event.index.toString());
    favorite.remove(event.index);
    emit(RemoveFromFavState());
    emit(FavoriteRemovedMessageState());
  }
}
