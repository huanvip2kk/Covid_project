import 'package:covid_19/presentation/common/common_widget.dart';
import 'package:covid_19/presentation/login_and_signup/login/ui/login_screen.dart';
import 'package:covid_19/presentation/login_and_signup/signup/signup_bloc/signup_bloc.dart';
import 'package:covid_19/presentation/login_and_signup/signup/signup_widget/signup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        if (state is SignupLoadingState) {
          return loading();
        } else if (state is SignupSuccessState) {
          return const LoginScreen();
        } else if (state is SignupFailureState) {
          return SignupWidget(
              formKey: _formKey,
              email: _email,
              password: _password,
              name: _name,
              context: context,
              message: state.message);
        }
        return SignupWidget(
            formKey: _formKey,
            email: _email,
            password: _password,
            name: _name,
            context: context,
            message: null);
      },
    );
  }
}
