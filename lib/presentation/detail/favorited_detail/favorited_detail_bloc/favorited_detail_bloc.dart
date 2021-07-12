import 'package:covid_19/data/model/countries_model.dart';
import 'package:covid_19/domain/usecase/covid_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorited_detail_event.dart';

part 'favorited_detail_state.dart';

class FavoritedDetailBloc extends Bloc<FavoritedDetailEvent, FavoritedDetailState> {
  FavoritedDetailBloc({required this.covidUsecase}) : super(FavoritedDetailInitState());

  final CovidUsecase covidUsecase;
  CountriesModel? countriesModel;

  @override
  Stream<FavoritedDetailState> mapEventToState(FavoritedDetailEvent event) async* {
    if (event is FavoritedDetailLoadEvent) {
      try {
        final response = await covidUsecase.getCountryByCountryName(event.countryName);
        yield FavoritedDetailLoadedState(countriesModel: response);
      } catch (e) {
        yield FavoritedDetailFailureState(message: e.toString());
      }
    }
  }
}
