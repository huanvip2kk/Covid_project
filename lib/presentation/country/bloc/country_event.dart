part of 'country_bloc.dart';

@immutable
abstract class CountryEvent {}
class OnCountriesSearchEvent extends CountryEvent {
  final String? search;
  OnCountriesSearchEvent({this.search}) ;
}
class LoadCountryEvent extends CountryEvent {
  // String? api;
  // LoadCountryEvent({this.api}) ;
}