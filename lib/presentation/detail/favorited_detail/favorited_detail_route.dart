import 'package:covid_19/data/api/covid_api.dart';
import 'package:covid_19/data/reposistory/covid_repo_impl.dart';
import 'package:covid_19/domain/usecase/covid_usecase.dart';
import 'package:covid_19/presentation/detail/favorited_detail/ui/favorited_detail_screen.dart';
import 'package:covid_19/data/ultils/favorited_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorited_detail_bloc/favorited_detail_bloc.dart';

class FavoritedDetailScreenRoute {
  static Widget route(FavoritedModel favoritedModel) => BlocProvider(
        create: (context) => FavoritedDetailBloc(
          covidUsecase: CovidUsecase(
            CovidRepoImpl(
              GetApi(
                Dio(),
              ),
            ),
          ),
        )..add(
            FavoritedDetailLoadEvent(
              countryName: favoritedModel.countryName.toString(),
            ),
          ),
    child:  FavoritedDetailScreen(favoritedModel: favoritedModel,),
      );
}
