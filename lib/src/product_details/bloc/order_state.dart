part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class DescriptionSeeState extends OrderState {
  final bool isSeeMore;
  DescriptionSeeState({required this.isSeeMore});
}
