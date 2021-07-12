import 'package:covid_19/data/api/covid_api.dart';
import 'package:covid_19/data/reposistory/covid_repo_impl.dart';
import 'package:covid_19/domain/usecase/covid_usecase.dart';
import 'package:covid_19/presentation/country/ui/country_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/country_bloc.dart';

class CountryScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) => CountryBloc(
          CovidUsecase(
            CovidRepoImpl(
              GetApi(
                Dio(),
              ),
            ),
          ),
        )..add(
            LoadCountryEvent(),
          ),
        child: const CountryScreen(),
      );
}
