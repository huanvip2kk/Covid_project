part of 'country_detail_bloc.dart';

abstract class CountryDetailState {}

class CountryDetailInitState extends CountryDetailState {}

class CountryDetailLoadedState extends CountryDetailState {

}

class CountryDetailLoadingState extends CountryDetailState {}

class CountryDetailFailureState extends CountryDetailState {
  String message;

  CountryDetailFailureState({required this.message});
}

class AddFavoritedSuccessState extends CountryDetailState {
  String countryName;

  AddFavoritedSuccessState({required this.countryName});
}

class AddFavoritedFailureState extends CountryDetailState {}
