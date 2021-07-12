import 'package:covid_19/presentation/login_and_signup/signup/signup_bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/signup_screen.dart';

class SignupScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) => SignupBloc(),
        child: const SignupScreen(),
      );
}
