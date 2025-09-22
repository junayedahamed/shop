import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FoodInitialEvent>(foodInitialEvent);
  }

  FutureOr<void> foodInitialEvent(
    FoodInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(FoodLoadingState());
      await Future.delayed(Duration(seconds: 3));
      emit(FoodLoadedState(data: ["ok", "hii", "Hello"]));
    } catch (e) {
      emit(FoodLoadFailedState());
    }
  }
}
