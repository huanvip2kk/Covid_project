part of 'login_bloc.dart';

abstract class LoginEvent {
  LoginEvent();
}

class LoginPressedEvent extends LoginEvent {
  final String? email;
  final String? password;

  LoginPressedEvent({this.email, this.password});
}

class LoginGooglePressedEvent extends LoginEvent {}

class LoginAnonymousPressedEvent extends LoginEvent {}
