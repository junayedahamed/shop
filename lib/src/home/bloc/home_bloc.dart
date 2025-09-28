import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  final ApiCalls apiCalls = ApiCalls();
  //food initial fetch event
  FutureOr<void> foodInitialEvent(
    FoodInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (products.isEmpty) {
        emit(FoodLoadingState());

        final d = await apiCalls.getData();

        products.addAll(d);

        emit(FoodLoadedState(data: products));
      } else {
        emit(FoodLoadedState(data: products));
      }
    } catch (e) {
      // log("message ${e.toString()}");
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
        final response = await apiCalls.addItemToFavorite(
          dotenv.env['USER_EMAIL'].toString(),
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

  FutureOr<void> addToCartEvent(
    AddToCartEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final res = cart.contains(event.data);
      // log((!res).toString());
      if (!res) {
        // log("message");
        cart.add(event.data);
        final result = await apiCalls.addItemToCart(
          dotenv.env['USER_EMAIL'].toString(),
          event.data.id,
        );
        emit(AddedToCartMsgState(cartAddMessage: result));
        // emit()
      } else {
        emit(AddedToCartMsgState(cartAddMessage: "Already added in cart"));
      }
    } catch (e) {
      emit(AddCartFailedState(errorMessage: e.toString()));
    }
  }

  //on refresh

  FutureOr<void> onrefreshEvent(
    OnrefreshEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // final List<ProductDataModel> products = [];
      emit(FoodLoadingState());
      products.addAll(await apiCalls.getData());
      // log(products.toString());
      emit(FoodLoadedState(data: products));
    } catch (e) {
      if (e is Map) {
        emit(FoodLoadFailedState(errorMessage: e['message']));
      }
    }
  }
}
