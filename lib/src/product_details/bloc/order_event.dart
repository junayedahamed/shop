part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

final class SeeMoreEvent extends OrderEvent {}

final class SeeLessEvent extends OrderEvent {}
