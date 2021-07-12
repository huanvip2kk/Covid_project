import 'package:covid_19/config/app_config.dart';
import 'package:covid_19/presentation/common/common_widget.dart';
import 'package:covid_19/presentation/country/bloc/country_bloc.dart';
import 'package:covid_19/utils/route/app_routing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountryLoadedWidget extends StatefulWidget {
  final CountriesLoadedState state;

  const CountryLoadedWidget({Key? key, required this.state}) : super(key: key);

  @override
  _CountryLoadedWidgetState createState() => _CountryLoadedWidgetState();
}

class _CountryLoadedWidgetState extends State<CountryLoadedWidget> {
  late final bool favorite;

  String key = 'keyChange';

  final ScrollController _scrollController = ScrollController();
  int _currentMax = 10;

  List list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = List.generate(
        10, (index) => widget.state.listCountry!.elementAt(index));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreList();
      }
    });
  }

  _getMoreList() {
    for (int i = _currentMax; i < _currentMax + 10; i++) {
      list.add(list);
    }
    _currentMax = _currentMax + 10;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: mediaHeight / 1.4,
      width: double.infinity,
      child: GridView.builder(
        itemCount: list.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1.0),
        itemBuilder: (ctx, index) {
          if (index == list.length) {
            return loading();
          }
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteDefine.countryDetailScreen.name,
                arguments: widget.state.listCountry!.elementAt(index),
              );
            },
            child: Card(
              elevation: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${index + 1}.  ${widget.state.listCountry!.elementAt(index).name.toString()}",
                      textAlign: TextAlign.center,
                      style: AppConfig.kSize24WeightBold,
                    ),
                    SizedBox(
                      child: Image.network(
                        widget.state.listCountry!
                            .elementAt(index)
                            .flag
                            .toString(),
                        fit: BoxFit.fill,
                      ),
                      height: 50,
                      width: 70,
                    ),
                    Text(
                        "New cases: ${widget.state.listCountry!.elementAt(index).newInfected.toString()}",
                        style: AppConfig.kSize14WeightBold),
                  ],
                ),
              ),
            ),
          );
        },
        controller: _scrollController,
      ),
    );
  }
}
