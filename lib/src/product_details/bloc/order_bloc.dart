import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});
    on<SeeMoreEvent>((event, emit) {
      // log("ok");
      emit(DescriptionSeeState(isSeeMore: true));
    });
    on<SeeLessEvent>((event, emit) {
      emit(DescriptionSeeState(isSeeMore: false));
    });
  }
}
