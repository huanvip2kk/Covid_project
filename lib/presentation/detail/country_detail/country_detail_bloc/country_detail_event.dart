part of 'country_detail_bloc.dart';

abstract class CountryDetailEvent {}

class CountryDetailLoadEvent extends CountryDetailEvent {}

class OnPressedFavoriteButtonEvent extends CountryDetailEvent {
  String countryName;
  String flag;

  OnPressedFavoriteButtonEvent({required this.countryName, required this.flag});
}
