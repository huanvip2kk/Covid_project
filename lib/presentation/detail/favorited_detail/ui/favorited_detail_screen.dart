import 'package:covid_19/config/app_config.dart';
import 'package:covid_19/presentation/common/common_widget.dart';
import 'package:covid_19/presentation/common/information_widget.dart';
import 'package:covid_19/presentation/detail/favorited_detail/favorited_detail_bloc/favorited_detail_bloc.dart';
import 'package:covid_19/data/ultils/favorited_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritedDetailScreen extends StatefulWidget {
 const FavoritedDetailScreen({
    Key? key,
    required this.favoritedModel,
  }) : super(key: key);
  final FavoritedModel favoritedModel;

  @override
  _FavoritedDetailScreenState createState() => _FavoritedDetailScreenState();
}

class _FavoritedDetailScreenState extends State<FavoritedDetailScreen> {
  User? user;

  onRefresh(userCred) {
    setState(() {
      user = userCred;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritedDetailBloc, FavoritedDetailState>(
      builder: (context, state) {
        if (state is FavoritedDetailLoadingState) {
          return loading();
        } else if (state is FavoritedDetailLoadedState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppConfig.kPrimaryColor,
              elevation: 0,
              title: Text(
                state.countriesModel.name.toString(),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: InformationWidget(
              newDeathText: state.countriesModel.newDeath.toString(),
              deathText: state.countriesModel.death.toString(),
              newRecoveredText: state.countriesModel.newRecovered.toString(),
              recoveredText: state.countriesModel.recovered.toString(),
              newInfectedText: state.countriesModel.newRecovered.toString(),
              infectedText: state.countriesModel.infected.toString(),
              valueRecovered: state.countriesModel.recovered as int,
              valueDeath: state.countriesModel.death as int,
              valueInfected: state.countriesModel.infected as int,
            ),
          );
        } else if (state is FavoritedDetailFailureState) {
          return Text(
            state.message.toString(),
          );
        }
        return loading();
      },
    );
  }
}
