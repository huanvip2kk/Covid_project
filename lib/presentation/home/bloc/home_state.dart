part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  //WorldCovidModel? _worldCovidModel;
}

class HomeInitial extends HomeState {}

class HomeSuccessState extends HomeState {
  final WorldCovidModel? worldCovidModel;

  HomeSuccessState({this.worldCovidModel});
}

class HomeLoadingState extends HomeState {}

class HomeFailState extends HomeState {
  final String? message;
  HomeFailState({this.message});
}
