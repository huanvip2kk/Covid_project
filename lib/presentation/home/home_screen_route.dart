import 'package:covid_19/data/api/covid_api.dart';
import 'package:covid_19/data/reposistory/covid_repo_impl.dart';
import 'package:covid_19/domain/usecase/covid_usecase.dart';
import 'package:covid_19/presentation/home/ui/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class HomeScreenRoute {
  static Widget get route => BlocProvider(
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
    child: const HomeScreen(),
      );
}
