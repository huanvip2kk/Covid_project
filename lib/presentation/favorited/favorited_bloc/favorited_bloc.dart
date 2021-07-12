import 'dart:async';

import 'package:covid_19/data/ultils/favorited_database_helper.dart';
import 'package:covid_19/data/ultils/favorited_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorited_event.dart';

part 'favorited_state.dart';

class FavoritedBloc extends Bloc<FavoritedEvent, FavoritedState> {
  FavoritedBloc() : super(FavoritedInitState());

  FavoritedDatabaseHelper db = FavoritedDatabaseHelper();

  @override
  Stream<FavoritedState> mapEventToState(FavoritedEvent event) async* {
    if (event is FavoritedLoadEvent) {
      try {
        final userName = FirebaseAuth.instance.currentUser!.email.toString();
        final listFavorited = await db.getFavoritedByUsername(userName);

        yield FavoritedLoadedState();

        yield FavoritedLoadedState(listFavorited: listFavorited);
      } catch (e) {
        yield FavoritedFailureState(message: e.toString());
      }
    } else if (event is FavoritedOnDeleteButtonPressedEvent) {
      try {
        int delete;
        delete = await db.deleteFavoritedByNameAndCountry(
            FirebaseAuth.instance.currentUser!.email.toString(),
            event.countryName);
        if (delete == 0) {
          yield DeleteFavoritedFailureState();
        } else {
          yield DeleteFavoritedSuccessState(countryName: event.countryName);
        }
      } catch (e) {
        yield DeleteFavoritedFailureState(message: e.toString());
      }
    }
  }
}
