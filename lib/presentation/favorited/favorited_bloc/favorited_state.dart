part of 'favorited_bloc.dart';

abstract class FavoritedState {}

class FavoritedInitState extends FavoritedState {}

class FavoritedLoadedState extends FavoritedState {
  List<FavoritedModel>? listFavorited;

  FavoritedLoadedState({this.listFavorited});
}

class FavoritedLoadingState extends FavoritedState {}

class FavoritedFailureState extends FavoritedState {
  String message;

  FavoritedFailureState({required this.message});
}

class DeleteFavoritedSuccessState extends FavoritedState {
  final String countryName;

  DeleteFavoritedSuccessState({required this.countryName});
}

class DeleteFavoritedFailureState extends FavoritedState {
  final String? message;

  DeleteFavoritedFailureState({this.message});
}
