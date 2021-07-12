import 'package:covid_19/config/app_config.dart';
import 'package:covid_19/presentation/common/chart/syncfunction_chart/syncfunction_chart.dart';
import 'package:flutter/material.dart';


class InformationWidget extends StatelessWidget {
  final String infectedText;

  final String newInfectedText;

  final String recoveredText;
  final String newRecoveredText;

  final String deathText;

  final String newDeathText;

  final String? countryName;

  final int valueDeath;
  final int valueInfected;
  final int valueRecovered;

  const InformationWidget({
    Key? key,
    required this.newDeathText,
    required this.deathText,
    required this.newRecoveredText,
    required this.recoveredText,
    required this.newInfectedText,
    required this.infectedText,
    this.countryName,
    required this.valueRecovered,
    required this.valueDeath,
    required this.valueInfected,
  }) : super(key: key);

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
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text('Chart', style: AppConfig.kSize24WeightBold),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SyncFunctionChart(
                valueRecovered: valueRecovered,
                valueInfected: valueInfected,
                valueDeath: valueDeath,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
