import 'package:covid_19/data/model/countries_model.dart';
import 'package:covid_19/data/model/world_covid_model.dart';
import 'package:covid_19/domain/reposistory/covid_reposistory.dart';

class CovidUsecase {
  final CovidRepo _covidRepo;

  CovidUsecase(this._covidRepo);

  Future<WorldCovidModel> getAll() => _covidRepo.getAll();

  Future<List<CountriesModel>> getCountries() => _covidRepo.getCountries();

  Future<CountriesModel> getCountryByCountryName(String countryName) =>
      _covidRepo.getCountryByCountryName(countryName);
}

// class CovidPostmanUsescase {
//   final CovidPostmanRepo _covidPostmanRepo;
//
//   CovidPostmanUsescase(this._covidPostmanRepo);
//
//   Future<List<WorldPostmanCovidModel>> getWorld() =>
//       _covidPostmanRepo.getWorld();
// }


