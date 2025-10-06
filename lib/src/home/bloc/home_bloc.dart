import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ocad/src/auth/save_user_data/session_manager.dart';
import 'package:ocad/src/database/apis/api_calls.dart';
import 'package:ocad/src/database/demo_data.dart';

import 'package:ocad/src/models/product_model/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<AllDataInitialEvent>(allDataInitialEvent);
    on<OnrefreshEvent>(onrefreshEvent);
    on<AddToFavouriteEvent>(addToFavouriteEvent);
    on<AddToCartEvent>(addToCartEvent);
  }

  // final RuntimeData runtimeData = RuntimeData();
  final ApiCalls apiCalls = ApiCalls();
  final SessionManager sessionManager = SessionManager();
  //all data initial fetch event
  FutureOr<void> allDataInitialEvent(
    AllDataInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (products.isEmpty) {
        emit(FoodLoadingState());

        final d = await apiCalls.getData();

        products.addAll(d);

        emit(ProductLoadedState(data: products));
      } else {
        emit(ProductLoadedState(data: products));
      }
    } catch (e) {
      // log("message ${e.toString()}");
      // log((e is Map).toString());
      if (e is Map) {
        emit(FoodLoadFailedState(errorMessage: e['message']));
      } else {
        emit(FoodLoadFailedState(errorMessage: e.toString()));
      }
    }
  }

  FutureOr<void> addToFavouriteEvent(
    AddToFavouriteEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final res = favorite.contains(event.data);
      final user = await sessionManager.getUser();
      if (user?.email == null || user == null) {
        if (event.context.mounted) {
          event.context.push('/login');
          return;
        }
      } else {
        log("fromfavorite: ${user.email}");
        if (!res) {
          final response = await apiCalls.addItemToFavorite(
            user.email,
            event.data.id,
          );
          // log(favorite.isEmpty.toString());
          emit(AddedToFavouriteState(message: response));

          favorite.add(event.data);
          emit(ProductLoadedState(data: products));
        } else {
          emit(AddedToFavouriteState(message: "Already added in favorite"));
        }
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
      final user = await sessionManager.getUser();
      if (user?.email == null || user == null) {
        if (event.context.mounted) {
          event.context.push('/login');
          return;
        }
      }
      // log((!res).toString());
      if (!res) {
        // log("message");
        cart.add(event.data);
        final result = await apiCalls.addItemToCart(user!.email, event.data.id);
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
      products.clear();
      products.addAll(await apiCalls.getData());
      // log(products.toString());
      emit(ProductLoadedState(data: products));
    } catch (e) {
      if (e is Map) {
        emit(FoodLoadFailedState(errorMessage: e['message']));
      } else {
        emit(FoodLoadFailedState(errorMessage: e.toString()));
      }
    }
  }
}
