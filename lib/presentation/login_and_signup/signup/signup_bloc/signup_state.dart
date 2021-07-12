part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class SignupInitialState extends SignupState {}
class SignupLoadingState extends SignupState {}
class SignupSuccessState extends SignupState {}
class SignupFailureState extends SignupState {
  final String? message;
  SignupFailureState({this.message});
}
