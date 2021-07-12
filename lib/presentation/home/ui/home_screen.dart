import 'package:covid_19/config/app_config.dart';
import 'package:covid_19/presentation/common/common_widget.dart';
import 'package:covid_19/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppConfig.kPrimaryColor,
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccessState) {
            final String infectedText =
                state.worldCovidModel!.infected.toString();

            final String newInfectedText =
                state.worldCovidModel!.newInfected.toString();

            final String recoveredText =
                state.worldCovidModel!.recovered.toString();
            final String newRecoveredText =
                state.worldCovidModel!.newRecovered.toString();

            final String deathText = state.worldCovidModel!.death.toString();

            final String newDeathText =
                state.worldCovidModel!.newDeath.toString();

            return HomeWidget(
                infectedText: infectedText,
                newInfectedText: newInfectedText,
                recoveredText: recoveredText,
                newRecoveredText: newRecoveredText,
                deathText: deathText,
                newDeathText: newDeathText);
          } else if (state is HomeLoadingState) {
            return loading();
          } else if (state is HomeFailState) {
            return FailureWidget(
              onPress: () {
                context.read<HomeBloc>().add(
                      LoadHomeEvent(),
                    );
              },
            );
          }
          return loading();
        },
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    Key? key,
    required this.infectedText,
    required this.newInfectedText,
    required this.recoveredText,
    required this.newRecoveredText,
    required this.deathText,
    required this.newDeathText,
  }) : super(key: key);

  final String infectedText;
  final String newInfectedText;
  final String recoveredText;
  final String newRecoveredText;
  final String deathText;
  final String newDeathText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 20, right: 20, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppConfig.kPrimaryColor.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: SizedBox(
                            height: 135,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                              color: AppConfig.kPrimaryColor),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Infected',
                                          style: AppConfig.kSize24WeightBold,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    infectedText,
                                    style:
                                        AppConfig.kSize24WeightBoldColorGreen,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('New infected +',
                                          style: AppConfig.kSize14),
                                      Text(
                                        newInfectedText,
                                        style: AppConfig
                                            .kSize14WeightBoldColorGreen,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: SizedBox(
                            height: 135,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                              color: AppConfig.kRecoveredColor),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Recovered',
                                          style: AppConfig.kSize24WeightBold,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    recoveredText,
                                    style: AppConfig.kSize24WeightBoldColorBlue,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('New recovered +',
                                          style: AppConfig.kSize14),
                                      Text(
                                        newRecoveredText,
                                        style: AppConfig
                                            .kSize14WeightBoldColorBlue,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: SizedBox(
                            height: 135,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                              color: AppConfig.kDangerColor),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Deaths',
                                          style: AppConfig.kSize24WeightBold,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    deathText,
                                    style: AppConfig.kSize24WeightBoldColorRed,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('New deaths +',
                                          style: AppConfig.kSize14),
                                      Text(
                                        newDeathText,
                                        style:
                                            AppConfig.kSize14WeightBoldColorRed,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Divider(
                height: 24,
                thickness: 3,
                color: AppConfig.kDangerColor,
                endIndent: 200,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.grey[200],
                  elevation: 5,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg_images/nurse.svg',
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Symptom\n checker',
                            style: AppConfig.kSize24WeightBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Base on common symptom')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Card(
                            elevation: 5,
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                'assets/svg_images/map.svg',
                                color: AppConfig.kPrimaryColor,
                              ),
                            )),
                      ),
                      Text(
                        'Map',
                        style: AppConfig.kSize14WeightBold,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Card(
                            elevation: 5,
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                'assets/svg_images/virus.svg',
                                color: AppConfig.kPrimaryColor,
                              ),
                            )),
                      ),
                      Text(
                        'Risk of infection',
                        style: AppConfig.kSize14WeightBold,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Card(
                            elevation: 5,
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                'assets/svg_images/upload.svg',
                                color: AppConfig.kPrimaryColor,
                              ),
                            )),
                      ),
                      Text(
                        'Data',
                        style: AppConfig.kSize14WeightBold,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Card(
                            elevation: 5,
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                'assets/svg_images/increase.svg',
                                color: AppConfig.kPrimaryColor,
                              ),
                            )),
                      ),
                      Text(
                        'Statistic',
                        style: AppConfig.kSize14WeightBold,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Card(
                            elevation: 5,
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                'assets/svg_images/use_mark.svg',
                                color: AppConfig.kPrimaryColor,
                              ),
                            )),
                      ),
                      Text(
                        'Mark',
                        style: AppConfig.kSize14WeightBold,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Card(
                          elevation: 5,
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              'assets/svg_images/phone.svg',
                              color: AppConfig.kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Call us',
                        style: AppConfig.kSize14WeightBold,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
