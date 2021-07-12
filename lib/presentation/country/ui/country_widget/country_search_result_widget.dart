import 'package:covid_19/config/app_config.dart';
import 'package:covid_19/presentation/country/bloc/country_bloc.dart';
import 'package:covid_19/utils/route/app_routing.dart';
import 'package:flutter/material.dart';

class CountrySearchResultWidget extends StatefulWidget {
  final SearchResultState state;
  final double mediaHeight;

  const CountrySearchResultWidget({
    Key? key,
    required this.state,
    required this.mediaHeight,
  }) : super(key: key);

  @override
  _CountrySearchResultWidgetState createState() => _CountrySearchResultWidgetState();
}

class _CountrySearchResultWidgetState extends State<CountrySearchResultWidget> {


  late final bool favorite;

  String key = 'keyChange';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.mediaHeight / 1.4,
      width: double.infinity,
      child: GridView.builder(
        itemCount: widget.state.listCountry!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1.0),
        itemBuilder: (ctx, index) => GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteDefine.countryDetailScreen.name, arguments: widget.state.listCountry!.elementAt(index));
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
                          .toString(),fit: BoxFit.fill,
                    ),
                    height: 50,
                    width: 70,
                  ),
                  Text(
                    "New cases: ${widget.state.listCountry!.elementAt(index).newInfected.toString()}",
                    style: AppConfig.kSize14WeightBold,
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
