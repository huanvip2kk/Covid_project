import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(
          LoginInitialState(),
        );

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    const Text('ok');
    if (event is LoginPressedEvent) {
      try {
        yield LoginLoadingState();
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email!,
          password: event.password!,
        );
        yield LoginSuccessState();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
        } else if (e.code == 'wrong-password') {
        }
        yield LoginFailureState(message: e.code.toString());
      }
    }

   else if (event is LoginGooglePressedEvent) {
      try {
        yield LoginLoadingState();
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        FirebaseAuth.instance.currentUser!.displayName.toString();
        yield LoginSuccessState();
      } catch (e) {
        yield LoginFailureState(message: "Fail to login with google");
      }
    }

    // else if (event is LoginAnonymousPressedEvent) {
    //   try {
    //     yield LoginLoadingState();
    //     await FirebaseAuth.instance.signInAnonymously();
    //     yield LoginSuccessState();
    //   } catch (e) {
    //     yield LoginFailureState(message: e.toString());
    //   }
    // }
  }
}
