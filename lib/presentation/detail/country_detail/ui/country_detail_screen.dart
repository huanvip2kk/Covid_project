import 'package:covid_19/config/app_config.dart';
import 'package:covid_19/data/model/countries_model.dart';
import 'package:covid_19/presentation/common/common_widget.dart';
import 'package:covid_19/presentation/common/information_widget.dart';
import 'package:covid_19/presentation/country/bloc/country_bloc.dart';
import 'package:covid_19/presentation/detail/country_detail/country_detail_bloc/country_detail_bloc.dart';
import 'package:covid_19/utils/route/app_routing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryDetailScreen extends StatefulWidget {
  const CountryDetailScreen({
    Key? key,
    required this.countries,
  }) : super(key: key);
  final CountriesModel? countries;

  @override
  _CountryDetailScreenState createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
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
    return BlocConsumer<CountryDetailBloc, CountryDetailState>(
      listener: (context, state) {
        if (user == null) {
          if (state is CountriesLoadedState) {
          } else if (state is AddFavoritedFailureState) {
            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: const Text("Login to add favorite"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteDefine.loginScreen.name);
                    },
                    child: const Text('Ok'),
                  ),
                ],
              ),
            );
          }
        } else {
          if (state is AddFavoritedSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Added ' + state.countryName.toString(),
                ),
              ),
            );
          } else if (state is AddFavoritedFailureState) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You have added this'),
              ),
            );
          }
        }
      },
      buildWhen: (context, state) {
        if (state is AddFavoritedFailureState ||
            state is AddFavoritedSuccessState) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state is CountryDetailLoadingState) {
          return loading();
        } else if (state is CountryDetailLoadedState) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: AppConfig.kPrimaryColor,
                elevation: 0,
                title: Text(
                  widget.countries!.name.toString(),
                  style: AppConfig.kSize24WeightBoldColorWhite,
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
                actions: [
                  IconButton(
                      onPressed: () async {
                        context.read<CountryDetailBloc>().add(
                              OnPressedFavoriteButtonEvent(
                                countryName:
                                    widget.countries!.name.toString(),
                                flag: widget.countries!.flag.toString(),
                              ),
                            );
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )),
                ],
              ),
              body: InformationWidget(
                countryName: widget.countries!.name.toString(),
                newDeathText: widget.countries!.newDeath.toString(),
                deathText: widget.countries!.death.toString(),
                newRecoveredText: widget.countries!.newRecovered.toString(),
                recoveredText: widget.countries!.recovered.toString(),
                newInfectedText: widget.countries!.newInfected.toString(),
                infectedText: widget.countries!.infected.toString(),
                valueRecovered: widget.countries!.recovered as int,
                valueDeath: widget.countries!.death as int,
                valueInfected: widget.countries!.infected as int,
              ));
        } else if (state is CountryDetailFailureState) {
          return Text(
            state.message.toString(),
          );
        }
        return Container();
      },
    );
  }
}
