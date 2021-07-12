part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class SignupPressed extends SignupEvent {
  final String email;
  final String password;
  final String name;

  SignupPressed(this.email, this.password,this.name);
}
