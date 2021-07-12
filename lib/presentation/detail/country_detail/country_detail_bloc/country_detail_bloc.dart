import 'package:covid_19/presentation/favorited/favorited_database_helper/favorited_database_helper.dart';
import 'package:covid_19/presentation/favorited/favorited_model/favorited_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'country_detail_event.dart';

part 'country_detail_state.dart';

class CountryDetailBloc extends Bloc<CountryDetailEvent, CountryDetailState> {
  CountryDetailBloc() : super(CountryDetailInitState());

  FavoritedDatabaseHelper db = FavoritedDatabaseHelper();

  @override
  Stream<CountryDetailState> mapEventToState(CountryDetailEvent event) async* {
    if (event is CountryDetailLoadEvent) {
      try {
        yield CountryDetailLoadedState();
      } catch (e) {
        yield CountryDetailFailureState(message: e.toString());
      }
    } else if (event is OnPressedFavoriteButtonEvent) {
      try {
        String? userName = FirebaseAuth.instance.currentUser!.email.toString();
        String countryName = event.countryName;
        String flag = event.flag.toString();
        final favoriteList =
            await db.getFavoritedByUsernameAndCountry(userName, countryName);

        FavoritedModel favoritedModel = FavoritedModel(
            userName: userName, flag: flag, countryName: countryName);
        if (favoriteList.isEmpty) {
          await db.insertFavorited(favoritedModel);
          yield AddFavoritedSuccessState(countryName: countryName);
        }
        else{
          yield AddFavoritedFailureState();
        }
      } catch (e) {
        yield AddFavoritedFailureState();
      }
    }
  }
}
