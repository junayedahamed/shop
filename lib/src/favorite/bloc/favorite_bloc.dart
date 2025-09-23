import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ocad/src/database/demo_data.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<RemoveFromFavEvent>(removeFromFavEvent);
  }

  FutureOr<void> removeFromFavEvent(
    RemoveFromFavEvent event,
    Emitter<FavoriteState> emit,
  ) {
    log(event.index.toString());
    fav.removeAt(event.index);
    emit(RemoveFromFavState());
    emit(FavoriteRemovedMessageState());
  }
}
