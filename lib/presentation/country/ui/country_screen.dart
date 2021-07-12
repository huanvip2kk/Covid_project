import 'package:covid_19/config/app_config.dart';
import 'package:covid_19/data/api/covid_api.dart';
import 'package:covid_19/data/reposistory/covid_repo_impl.dart';
import 'package:covid_19/domain/usecase/covid_usecase.dart';
import 'package:covid_19/presentation/common/common_widget.dart';
import 'package:covid_19/presentation/country/bloc/country_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'country_widget/country_loaded_success_widget.dart';
import 'country_widget/country_search_result_widget.dart';
import 'country_widget/search_bar_widget.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({Key? key}) : super(key: key);

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  final _search = TextEditingController();

  late final bool favorite;

  String key = 'keyChange';

  @override
  Widget build(context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppConfig.kPrimaryColor,
        title: Text(
          'Country',
          style: AppConfig.kSize24WeightBoldColorWhite,
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
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
        child: BlocBuilder<CountryBloc, CountryState>(
          builder: (context, state) {
            if (state is CountriesLoadedState || state is SearchResultState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SearchBarWidget(
                      mediaHeight: mediaHeight,
                      searchController: _search,
                    ),
                    BlocBuilder<CountryBloc, CountryState>(
                      builder: (context, state) {
                        if (state is CountriesLoadedState) {
                          return CountryLoadedWidget(
                            state: state,
                          );
                        } else if (state is SearchResultState) {
                          return CountrySearchResultWidget(
                            state: state,
                            mediaHeight: mediaHeight,
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              );
            } else if (state is CountryLoadingState) {
              return Center(
                child: loading(),
              );
            } else if (state is CountryFailState) {
              return FailureWidget(
                onPress: () {
                  context.read<CountryBloc>().add(
                        LoadCountryEvent(),
                      );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
