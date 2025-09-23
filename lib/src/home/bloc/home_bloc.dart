import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
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
        final uri = Uri.parse('https://test-v37i.onrender.com/get');
        final http.Response response = await http.get(uri);
        if (response.statusCode == 200) {
          final values = jsonDecode(response.body);
          foodData.addAll(values);
          emit(FoodLoadedState(data: foodData));
        }
      } else {
        emit(FoodLoadedState(data: foodData));
      }
      // emit(FoodLoadedState(data: ["ok", "hii", "Hello"]));
    } catch (e) {
      emit(FoodLoadFailedState());
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

  FutureOr<void> onrefreshEvent(
    OnrefreshEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(FoodLoadingState());
      final uri = Uri.parse('https://test-v37i.onrender.com/get');
      final http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        final values = jsonDecode(response.body);
        foodData.addAll(values);
        emit(FoodLoadedState(data: foodData));
      }
    } catch (e) {
      emit(FoodLoadFailedState());
    }
  }
}
