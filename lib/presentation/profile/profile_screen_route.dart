import 'package:covid_19/presentation/profile/ui/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_bloc/profile_bloc.dart';

class ProfileScreenRoute {
  static Widget get route => BlocProvider(
        create: (context) => ProfileBloc()
          ..add(
            ProfileLoadEvent(),
          ),
        child: const ProfileScreen(),
      );
}
