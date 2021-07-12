import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileLoadEvent) {
      try {

        yield ProfileLoadedState();
      } catch (e) {
        yield ProfileFailureState(message: e.toString());
      }
    }
    else if (event is ProfileChangeEvent) {
      try {
        //FirebaseAuth.instance.currentUser!.updatePhotoURL('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg');

        FirebaseAuth.instance.currentUser!.updateDisplayName(event.username);
        yield ProfileLoadedState();
      } catch (e) {
        yield ProfileFailureState(message: e.toString());
      }
    }
  }
}