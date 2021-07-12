part of 'profile_bloc.dart';

abstract class ProfileEvent{}
class ProfileLoadEvent extends ProfileEvent{}

class ProfileChangeEvent extends ProfileEvent{
  String username;
  ProfileChangeEvent({required this.username});
}
