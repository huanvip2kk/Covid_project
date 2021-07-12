part of 'country_bloc.dart';

abstract class CountryState {}

class CountryInitial extends CountryState {}

class CountriesLoadedState extends CountryState {
  final List<CountriesModel>? listCountry;

  CountriesLoadedState({this.listCountry});
}

class CountryLoadingState extends CountryState {}

class CountryFailState extends CountryState {}

class SearchResultState extends CountryState {
  List<CountriesModel>? listCountry;

  SearchResultState({this.listCountry});
}
