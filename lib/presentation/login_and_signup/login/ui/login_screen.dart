import 'package:covid_19/presentation/common/common_widget.dart';
import 'package:covid_19/presentation/common/landing_page/ui/landing_page.dart';
import 'package:covid_19/presentation/login_and_signup/login/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_widget/login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return loading();
          } else if (state is LoginSuccessState) {
            return const LandingPage();
          } else if (state is LoginFailureState) {
            return LoginWidget(
                formKey: _formKey,
                email: email,
                password: password,
                message: state.message,
                context: context);
          } else {
            return LoginWidget(
                formKey: _formKey,
                email: email,
                password: password,
                message: null,
                context: context);
          }
        },
      ),
    );
  }
}
