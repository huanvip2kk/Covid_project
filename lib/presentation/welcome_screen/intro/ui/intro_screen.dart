import 'package:covid_19/utils/route/app_routing.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  /// When tutorial is done.
  void onDonePress() {
    Navigator.pushReplacementNamed(context, RouteDefine.landingPage.name);
  }

  void onSkipPress() {
    Navigator.pushReplacementNamed(context, RouteDefine.landingPage.name);
  }

  List<Slide> slides = [];

  @override
  Widget build(BuildContext context) {
    slides.clear();

    slides.add(
      Slide(
        title: ('On proper personal hygiene'
            ' and containment....'),
        styleTitle: (const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black)),
        description:
            ('"What we seeing being successful are the fundamentals of public health.." - Dr. Maria Van Kerkhove, technical lead, World Health Organization, infectious disease epidemiologist.'),
        styleDescription: (const TextStyle(
            fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold)),
        marginDescription: const EdgeInsets.only(top: 30, left: 20, right: 20),
        pathImage: 'assets/images/intro1.png',
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      Slide(
        title: ('On healthcare systems...'),
        styleTitle: (const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black)),
        description:
            ('Epidemics are a stress test for a system....the issue is how much resilience is built into those systems. Our hospital systems are designed to deliver at 99% efficiency. There is no space for them to deliver anymore. - Dr. Michael J. Ryan, WHO Informal Advisory Group"'),
        styleDescription: (const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey)),
        marginDescription: const EdgeInsets.only(top: 30, left: 20, right: 20),
        pathImage: 'assets/images/intro2.png',
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      Slide(
        title: ('On assessing the risks and containing the virus...'),
        styleTitle: (const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black)),
        description:
            ('Asking the question "are we doing enough" regularly and repeatedly is critical."- Dr. Maria Van Kerkhove, technical lead, World Health Organization, infectious disease epidemiologist.'),
        styleDescription: (const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey)),
        marginDescription: const EdgeInsets.only(top: 30, left: 20, right: 20),
        pathImage: 'assets/images/intro3.png',
        backgroundColor: Colors.white,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: IntroSlider(
          showSkipBtn: true,
          showPrevBtn: true,
          slides: slides,
          onDonePress: onDonePress,
          onSkipPress: onSkipPress,
          renderNextBtn: const Text('Next'),
          renderDoneBtn: const Text('Let\'s start'),
          renderSkipBtn: const Text('Skip'),
          colorDot: Colors.grey,
          colorActiveDot: Colors.blue,
          // widthDoneBtn: buttonWidth,
          isScrollable: true,
        ),
      ),
    );
  }
}
