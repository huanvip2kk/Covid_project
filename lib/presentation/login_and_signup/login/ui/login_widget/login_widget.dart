import 'package:covid_19/presentation/login_and_signup/login/login_bloc/login_bloc.dart';
import 'package:covid_19/utils/route/app_routing.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget(
      {Key? key,
      required GlobalKey<FormState> formKey,
      required this.email,
      required this.password,
      required this.context,
      required this.message})
      : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController email;
  final TextEditingController password;
  final BuildContext context;
  final String? message;

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
          color: Colors.amberAccent,
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
      body: Form(
        key: widget._formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(visible: _isVisible, child: showAlert()),
                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: 343,
                        height: 253,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/login.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Log in',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24.0,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Login with social networks',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.facebookSquare,
                                  size: 40,
                                ),
                                onPressed: () {},
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.instagramSquare,
                                  size: 40,
                                ),
                                onPressed: () {},
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.google,
                                  size: 40,
                                ),
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                        LoginGooglePressedEvent(),
                                      );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: widget.email,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined)),
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
                          controller: widget.password,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.password_outlined),
                            suffixIcon: TextButton(
                              onPressed: _toggle,
                              child: Icon(_obscureText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined),
                            ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot password',
                              ),
                            ),

                            //Sign in with guest
                            TextButton(
                              onPressed: () async {
                                // context
                                //     .read<LoginBloc>()
                                //     .add(LoginAnonymousPressedEvent());
                              },
                              child: const Text(
                                'Login with guest',
                              ),
                            ),
                          ],
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
                                      context.read<LoginBloc>().add(
                                            LoginPressedEvent(
                                              email: widget.email.text,
                                              password: widget.password.text,
                                            ),
                                          );
                                    }
                                  },
                                  child: const Text('Login'),
                                  style: ButtonStyle(
                                    // backgroundColor:
                                    //     MaterialStateProperty.all(
                                    //         kPrimaryColor),
                                    // padding: MaterialStateProperty.all(
                                    //   EdgeInsets.all(50),
                                    // ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                    ),
                                    // textStyle: MaterialStateProperty.all(
                                    //   TextStyle(color: Colors.black),
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteDefine.signupScreen.name);
                              },
                              child: const Text(
                                'No account, Sign up',
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
                    // AlertDialog(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
