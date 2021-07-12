part of 'profile_bloc.dart';

abstract class ProfileState{}

class ProfileInitState extends ProfileState{}
class ProfileLoadedState extends ProfileState{}
class ProfileLoadingState extends ProfileState{}
class ProfileFailureState extends ProfileState{
  String message;
  ProfileFailureState({required this.message});
}