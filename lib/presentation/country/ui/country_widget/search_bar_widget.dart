import 'package:covid_19/config/app_config.dart';
import 'package:covid_19/presentation/country/bloc/country_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget(
      {Key? key, required this.mediaHeight, this.searchController})
      : super(key: key);

  final double mediaHeight;
  final TextEditingController? searchController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mediaHeight / 10,
      child: Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppConfig.kPrimaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: AppConfig.kPrimaryColor.withOpacity(0.2),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (s) {
                        context.read<CountryBloc>().add(
                              OnCountriesSearchEvent(
                                  search: searchController!.text),
                            );
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: const TextStyle(
                          color: Colors.black26,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
