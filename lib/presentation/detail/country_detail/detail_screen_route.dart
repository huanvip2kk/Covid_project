import 'package:covid_19/data/model/countries_model.dart';
import 'package:flutter/material.dart';

import 'ui/country_detail_screen.dart';

class CountryDetailScreenRoute {
  static Widget route(CountriesModel? countriesModel) => CountryDetailScreen(
        countries: countriesModel,
      );
}
