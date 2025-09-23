import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ocad/src/database/apis/api_calls.dart';
import 'package:ocad/src/database/demo_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FoodInitialEvent>(foodInitialEvent);
    on<OnrefreshEvent>(onrefreshEvent);
    on<AddToFavouriteEvent>(addToFavouriteEvent);
    on<AddToCartEvent>(addToCartEvent);
  }

  //food initial fetch event
  FutureOr<void> foodInitialEvent(
    FoodInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (foodData.isEmpty) {
        emit(FoodLoadingState());
        foodData.addAll(await ApiCalls.getData());

        emit(FoodLoadedState(data: foodData));
      } else {
        emit(FoodLoadedState(data: foodData));
      }
    } catch (e) {
      log("message ${e.toString()}");
      // log((e is Map).toString());
      if (e is Map) {
        emit(FoodLoadFailedState(errorMessage: e['message']));
      }
    }
  }

  FutureOr<void> addToFavouriteEvent(
    AddToFavouriteEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(AddedToFavouriteState());
    fav.add(event.data);
  }

  FutureOr<void> addToCartEvent(AddToCartEvent event, Emitter<HomeState> emit) {
    emit(AddedToCartState());
    cart.add(event.data);
  }

  //on refresh

  FutureOr<void> onrefreshEvent(
    OnrefreshEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(FoodLoadingState());
      final foodData = await ApiCalls.getData();
      log(foodData.toString());
      emit(FoodLoadedState(data: foodData));
    } catch (e) {
      if (e is Map) {
        emit(FoodLoadFailedState(errorMessage: e['message']));
      }
    }
  }
}
