import 'package:covid_19/presentation/login_and_signup/login/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc/login_bloc.dart';

class LoginScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) => LoginBloc(),
        child: const LoginScreen(),
      );
}
