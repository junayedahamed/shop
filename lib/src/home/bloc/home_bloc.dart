import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ocad/src/database/apis/api_calls.dart';
import 'package:ocad/src/database/demo_data.dart';

import 'package:ocad/src/model/product_model/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FoodInitialEvent>(foodInitialEvent);
    on<OnrefreshEvent>(onrefreshEvent);
    on<AddToFavouriteEvent>(addToFavouriteEvent);
    on<AddToCartEvent>(addToCartEvent);
  }

  // final RuntimeData runtimeData = RuntimeData();
  //food initial fetch event
  FutureOr<void> foodInitialEvent(
    FoodInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // final List<ProductDataModel> products = [];
      // log(products.isEmpty.toString());
      if (products.isEmpty) {
        emit(FoodLoadingState());
        // log("here");
        final d = await ApiCalls.getData();
        // log(d.toString());
        // runtimeData.setAllDataToProduct = d;
        products.addAll(d);

        emit(FoodLoadedState(data: products));
      } else {
        emit(FoodLoadedState(data: products));
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
  ) async {
    try {
      final res = favorite.contains(event.data);

      if (!res) {
        final response = await ApiCalls.addItemToFavorite(
          "useremailapp",
          event.data.id,
        );
        // log(favorite.isEmpty.toString());
        emit(AddedToFavouriteState(message: response));
        favorite.add(event.data);
      } else {
        emit(AddedToFavouriteState(message: "Already added in favorite"));
      }
    } catch (e) {
      emit(AddedToFavouriteState(message: e.toString()));
    }
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
      // final List<ProductDataModel> products = [];
      emit(FoodLoadingState());
      products.addAll(await ApiCalls.getData());
      // log(products.toString());
      emit(FoodLoadedState(data: products));
    } catch (e) {
      if (e is Map) {
        emit(FoodLoadFailedState(errorMessage: e['message']));
      }
    }
  }
}
