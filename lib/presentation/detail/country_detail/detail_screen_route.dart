import 'package:covid_19/data/model/countries_model.dart';
import 'package:covid_19/presentation/detail/country_detail/country_detail_bloc/country_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/country_detail_screen.dart';

class CountryDetailScreenRoute {
  static Widget route(CountriesModel? countriesModel) => BlocProvider(
        create: (context) => CountryDetailBloc()
          ..add(
            CountryDetailLoadEvent(),
          ),
        child: CountryDetailScreen(
          countries: countriesModel,
        ),
      );
}
