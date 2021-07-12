import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_19/data/model/world_covid_model.dart';
import 'package:covid_19/domain/usecase/covid_usecase.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CovidUsecase _covidUsecase;

  HomeBloc(this._covidUsecase) : super(HomeInitial());

  List<WorldCovidModel> listRetrofit = [];

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is LoadHomeEvent) {
      try {
        final response = await _covidUsecase.getAll();
        WorldCovidModel worldCovidModel = response;
        yield HomeSuccessState(worldCovidModel: worldCovidModel);
      } catch (e) {
        yield HomeFailState(message: e.toString());
      }
    }
  }
}
