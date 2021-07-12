import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitialState());

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignupPressed) {
      yield SignupLoadingState();
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        userCredential.user!.updateDisplayName(event.name);
        yield SignupSuccessState();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
        } else if (e.code == 'wrong-password') {
        }
        yield SignupFailureState(message: e.code.toString());
      }
    }
  }
}
