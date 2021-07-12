part of 'favorited_detail_bloc.dart';

abstract class FavoritedDetailState{}

class FavoritedDetailInitState extends FavoritedDetailState{}
class FavoritedDetailLoadedState extends FavoritedDetailState{
  CountriesModel countriesModel;
  FavoritedDetailLoadedState({required this.countriesModel});
}
class FavoritedDetailLoadingState extends FavoritedDetailState{}
class FavoritedDetailFailureState extends FavoritedDetailState{
  String message;
  FavoritedDetailFailureState({required this.message});
}