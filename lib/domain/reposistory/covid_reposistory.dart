import 'package:covid_19/data/model/countries_model.dart';
import 'package:covid_19/data/model/world_covid_model.dart';

abstract class CovidRepo
{
  Future<WorldCovidModel> getAll();
  Future<List<CountriesModel>> getCountries();
  Future<CountriesModel> getCountryByCountryName(String countryName);

}

