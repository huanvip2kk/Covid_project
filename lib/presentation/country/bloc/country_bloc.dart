import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_19/data/model/countries_model.dart';
import 'package:covid_19/domain/usecase/covid_usecase.dart';
import 'package:meta/meta.dart';

part 'country_event.dart';

part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc(this._covidUsecase) : super(CountryInitial());

  final CovidUsecase _covidUsecase;
  List<CountriesModel> listRetrofit = [];
  List<CountriesModel> listSearch = [];

  @override
  Stream<CountryState> mapEventToState(
    CountryEvent event,
  ) async* {
    if (event is LoadCountryEvent) {
      yield CountryLoadingState();
      try {
        yield CountryLoadingState();
        final response = await _covidUsecase.getCountries();
        listRetrofit = response;
        yield CountriesLoadedState(listCountry: listRetrofit);
      } catch (e) {
        yield CountryFailState();
      }
    } else if (event is OnCountriesSearchEvent) {
      listSearch.clear();
      for (int i = 0; i < listRetrofit.length; i++) {
        if (listRetrofit.elementAt(i).name!.toLowerCase().contains(
                  event.search.toString().toLowerCase(),
                ) ||
            listRetrofit.elementAt(i).iso2.toString().toLowerCase().contains(
                  event.search.toString().toLowerCase(),
                )) {
          listSearch.add(listRetrofit.elementAt(i));
        }
      }
      yield SearchResultState(listCountry: listSearch);
    }
  }
}
