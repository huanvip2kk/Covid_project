
import 'package:covid_19/config/app_config.dart';

import '../note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class MyPieChart extends StatefulWidget {
  const MyPieChart(
      {Key? key,
      required this.valueDeath,
      required this.valueInfected,
      required this.valueRecovered})
      : super(key: key);
  final int valueDeath;
  final int valueInfected;
  final int valueRecovered;

  @override
  _MyPieChart createState() => _MyPieChart();
}

class _MyPieChart extends State<MyPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: 250,
          child: PieChart(
            PieChartData(
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  setState(() {
                    final desiredTouch =
                        pieTouchResponse.touchInput is! PointerExitEvent &&
                            pieTouchResponse.touchInput is! PointerUpEvent;
                    if (desiredTouch &&
                        pieTouchResponse.touchedSection != null) {
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    } else {
                      touchedIndex = -1;
                    }
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: _mediaQuery.width/ 10,
                sections: showingSections()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
          child: Note(
            title3: "Infected",
            title2: "Death",
            title1: "Recovered",
            colors3: AppConfig.kPrimaryColor,
            colors2: AppConfig.kDangerColor,
            colors1: AppConfig.kRecoveredColor,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    final formatter = NumberFormat("#,###");
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 24.0 : 14.0;
      final radius = isTouched
          ? MediaQuery.of(context).size.height / 7
          : MediaQuery.of(context).size.height / 10;
      String title(String t) {
        if (t.isNotEmpty && t.length < 4) {
          return t;
        } else if (t.length > 3 && t.length < 7) {
          return formatter.format(int.parse(t)).substring(0, t.length - 3) +
              "K";
        } else {
          return formatter.format(int.parse(t)).substring(0, t.length - 6) +
              "M";
        }
      }

      double sum =
          (widget.valueDeath + widget.valueRecovered + widget.valueInfected) *
              1.0;
      String ratio(double value) {
        double result = value * 100 / sum;
        return result.toStringAsFixed(1) + "%";
      }

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppConfig.kPrimaryColor,
            value: widget.valueInfected * 1.0,
            title: isTouched
                ? title(widget.valueInfected.toString())
                : ratio(widget.valueInfected * 1.0),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: AppConfig.kRecoveredColor,
            value: widget.valueRecovered * 1.0,
            title: isTouched
                ? title(widget.valueRecovered.toString())
                : ratio(widget.valueRecovered * 1.0),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: AppConfig.kDangerColor,
            value: widget.valueDeath * 1.0,
            title: isTouched
                ? title(widget.valueDeath.toString())
                : ratio(widget.valueDeath * 1.0),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
