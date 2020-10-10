part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeDataProcessing extends HomeState {}

class HomeDataProcessed extends HomeState {
  final List<WeightModel> listWeightModel;

  const HomeDataProcessed(this.listWeightModel);
}

class HomeDataError extends HomeState {
  final String message;
  const HomeDataError(this.message);
}
