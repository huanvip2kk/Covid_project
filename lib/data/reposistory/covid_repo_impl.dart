import 'package:covid_19/data/api/covid_api.dart';
import 'package:covid_19/data/model/countries_model.dart';
import 'package:covid_19/data/model/world_covid_model.dart';
import 'package:covid_19/domain/reposistory/covid_reposistory.dart';

class CovidRepoImpl extends CovidRepo {
  final GetApi _getApi;

  CovidRepoImpl(this._getApi);

  @override
  Future<WorldCovidModel> getAll() async {
    final allResponse = await _getApi.getAll();
    return allResponse;
  }

  @override
  Future<List<CountriesModel>> getCountries() async {
    final countriesResponse = await _getApi.getCountries();
    return countriesResponse;
  }

  @override
  Future<CountriesModel> getCountryByCountryName(String countryName) async {
    final response = await _getApi.getCountryByCountryName(countryName);
    return response;
  }
}
