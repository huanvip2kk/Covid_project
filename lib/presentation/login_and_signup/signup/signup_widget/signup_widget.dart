import 'package:covid_19/config/app_config.dart';
import 'package:covid_19/presentation/login_and_signup/signup/signup_bloc/signup_bloc.dart';
import 'package:covid_19/utils/route/app_routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget(
      {Key? key,
      required GlobalKey<FormState> formKey,
      required this.email,
      required this.password,
      required this.name,
      required this.context,
      required this.message})
      : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController name;
  final BuildContext context;
  final String? message;

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _isVisible = true;

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    late String? _error = widget.message;
    Widget showAlert() {
      if (_error != null) {
        return Container(
          color: AppConfig.kPrimaryColor,
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.error_outline),
              ),
              Expanded(
                child: Text(
                  _error.toString(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      showToast();
                    });
                  },
                ),
              )
            ],
          ),
        );
      }
      return const SizedBox(
        height: 0,
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppConfig.kBackgroundColor,
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: const Icon(
              Icons.navigate_before,
              color: Colors.black,
            ),
            width: 48,
            height: 48,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
      ),
      body: Form(
        key: widget._formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: _isVisible,
                    child: showAlert(),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/signup.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                    width: 343,
                    height: 253,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: const [
                      Text(
                        'Sign up',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Create your account',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: widget.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          if (value!.length < 4) {
                            return 'Name must longer than 4 charactor';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: widget.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value ?? '');
                          if (!emailValid) return 'Invalid email';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: widget.password,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: TextButton(
                              onPressed: _toggle,
                              child: Icon(_obscureText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined)),
                        ),
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Password must longer than 6 charactor';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (widget._formKey.currentState!
                                      .validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     content: Text('Processing Data'),
                                    //   ),
                                    // );
                                    context.read<SignupBloc>().add(
                                          SignupPressed(
                                            widget.email.text,
                                            widget.password.text,
                                            widget.name.text,
                                          ),
                                        );
                                  }
                                },
                                child: const Text('Signup'),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteDefine.loginScreen.name);
                        },
                        child: const Text(
                          'Aready have an account? Log in',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
