import 'package:covid_19/data/model/countries_model.dart';
import 'package:covid_19/data/model/world_covid_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'covid_api.g.dart';

@RestApi(baseUrl: 'https://disease.sh/v3/covid-19')

abstract class GetApi{
  factory GetApi(Dio dio) = _GetApi;

  @GET('/all')
  Future<WorldCovidModel> getAll();

  @GET('/countries')
  Future<List<CountriesModel>> getCountries();

  @GET("/countries/{country}")
  Future<CountriesModel> getCountryByCountryName(@Path("country") String countryName);

}