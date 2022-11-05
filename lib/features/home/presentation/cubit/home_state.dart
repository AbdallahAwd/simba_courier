part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class SubmitLoading extends HomeState {}

class GenerateLoading extends HomeState {}

class Sendloading extends HomeState {}

class Sent extends HomeState {}

class Generated extends HomeState {}

class Submitted extends HomeState {}

class PickLoading extends HomeState {}

class PickDLoading extends HomeState {}

class PickError extends HomeState {
  final Failure error;

  const PickError(this.error);
}

class Picked extends HomeState {}
