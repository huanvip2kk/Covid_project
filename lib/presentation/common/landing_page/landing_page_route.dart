import 'package:covid_19/data/api/covid_api.dart';
import 'package:covid_19/data/reposistory/covid_repo_impl.dart';
import 'package:covid_19/domain/usecase/covid_usecase.dart';
import 'package:covid_19/presentation/common/landing_page/ui/landing_page.dart';
import 'package:covid_19/presentation/country/bloc/country_bloc.dart';
import 'package:covid_19/presentation/home/bloc/home_bloc.dart';
import 'package:covid_19/presentation/profile/profile_bloc/profile_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LandingPageRoute{
  static Widget get route => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => HomeBloc(
          CovidUsecase(
            CovidRepoImpl(
              GetApi(
                Dio(),
              ),
            ),
          ),
        )..add(
          LoadHomeEvent(),
        ),
      ),
      BlocProvider(
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
      ),
      BlocProvider(
        create: (context) => ProfileBloc()
          ..add(
            ProfileLoadEvent(),
          ),
      ),
    ],
    child: const LandingPage()
  );
}