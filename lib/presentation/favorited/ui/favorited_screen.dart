import 'package:covid_19/presentation/common/common_widget.dart';
import 'package:covid_19/presentation/favorited/favorited_bloc/favorited_bloc.dart';
import 'package:covid_19/utils/route/app_routing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritedScreen extends StatefulWidget {
  const FavoritedScreen({Key? key}) : super(key: key);

  @override
  _FavoritedScreenState createState() => _FavoritedScreenState();
}

class _FavoritedScreenState extends State<FavoritedScreen> {
  User? user;

  onRefresh(userCred) {
    setState(() {
      user = userCred;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Favorited list'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login to see favorited list,",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 14,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteDefine.loginScreen.name);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Login now?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorited list'),
      ),
      body: BlocProvider(
        create: (context) => FavoritedBloc()..add(FavoritedLoadEvent()),
        child: BlocBuilder<FavoritedBloc, FavoritedState>(
          builder: (context, state) {
            if (state is FavoritedLoadingState) {
              return loading();
            } else if (state is FavoritedLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: state.listFavorited!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteDefine.favoritedDetailScreen.name,
                                arguments:
                                    state.listFavorited!.elementAt(index),
                              );
                            },
                            child: Card(
                              child: ListTile(
                                title: Text(state.listFavorited!
                                    .elementAt(index)
                                    .countryName
                                    .toString()),
                                leading: SizedBox(
                                  width: 50,
                                  height: 40,
                                  child: Image.network(
                                    state.listFavorited!
                                        .elementAt(index)
                                        .flag
                                        .toString(),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) => AlertDialog(
                                        title: const Text("Want to delete?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(dialogContext).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              context.read<FavoritedBloc>().add(
                                                    FavoritedOnDeleteButtonPressedEvent(
                                                      countryName: state
                                                          .listFavorited!
                                                          .elementAt(index)
                                                          .countryName
                                                          .toString(),
                                                    ),
                                                  );
                                              context
                                                  .read<FavoritedBloc>()
                                                  .add(FavoritedLoadEvent());
                                              Navigator.of(dialogContext).pop();
                                            },
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            } else if (state is FavoritedFailureState) {
              return Text(
                state.message.toString(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

//
// import 'package:covid_19/data/api/covid_api.dart';
// import 'package:covid_19/data/reposistory/covid_repo_impl.dart';
// import 'package:covid_19/domain/usecase/covid_usecase.dart';
// import 'package:covid_19/presentation/common/common_widget.dart';
// import 'package:covid_19/presentation/detail/ui/detail_screen.dart';
// import 'package:covid_19/presentation/drawer_view/favorited/favorited_bloc/favorited_bloc.dart';
// import 'package:covid_19/utils/route/app_routing.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class FavoritedScreen extends StatefulWidget {
//   @override
//   _FavoritedScreenState createState() => _FavoritedScreenState();
// }
//
// class _FavoritedScreenState extends State<FavoritedScreen> {
//   User? user;
//
//   onRefresh(userCred) {
//     setState(() {
//       user = userCred;
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     onRefresh(FirebaseAuth.instance.currentUser);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (user == null) {
//       return Scaffold(
//         appBar: AppBar(),
//         body: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "You're not ",
//                 style: TextStyle(fontSize: 24),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, RouteDefine.LoginScreen.name);
//                 },
//                 child: const Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'login',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 24,
//                         color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Favorited list'),
//       ),
//       body: BlocProvider(
//         create: (context) => FavoritedBloc(
//           CovidUsescase(
//             CovidRepoImpl(
//               GetApi(
//                 Dio(),
//               ),
//             ),
//           ),
//         )..add(
//           FavoritedLoadEvent(),
//         ),
//         child: BlocBuilder<FavoritedBloc, FavoritedState>(
//           builder: (context, state) {
//             if (state is FavoritedLoadingState) {
//               return loadingWidget();
//             } else if (state is FavoritedLoadedState) {
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       width: double.infinity,
//                       height: MediaQuery.of(context).size.height,
//                       child: ListView.builder(
//                         itemCount: state.listFavorited!.length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => DetailScreen(
//                                       countries: state.listCountries!
//                                           .elementAt(index)),
//                                 ),
//                               );
//                             },
//                             child: Card(
//                               child: ListTile(
//                                 title: Text(
//                                   state.listFavorited!
//                                       .elementAt(index)
//                                       .countryName
//                                       .toString(),
//                                 ),
//                                 leading: SizedBox(
//                                   width: 50,
//                                   height: 40,
//                                   child: Image.network(
//                                     state.listFavorited!
//                                         .elementAt(index)
//                                         .flag
//                                         .toString(),
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                                 trailing: IconButton(
//                                   icon: const Icon(Icons.delete),
//                                   onPressed: () async {
//                                     await showDialog(
//                                       context: context,
//                                       builder: (dialogContext) => AlertDialog(
//                                         title: const Text("Want to delete?"),
//                                         actions: [
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.of(dialogContext).pop();
//                                             },
//                                             child: const Text('Cancel'),
//                                           ),
//                                           ElevatedButton(
//                                             onPressed: () {
//                                               context.read<FavoritedBloc>().add(
//                                                 FavoritedOnDeleteButtonPressedEvent(
//                                                   countryName: state
//                                                       .listFavorited!
//                                                       .elementAt(index)
//                                                       .countryName
//                                                       .toString(),
//                                                 ),
//                                               );
//                                               Navigator.of(dialogContext).pop();
//                                             },
//                                             child: const Text('Ok'),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                     context
//                                         .read<FavoritedBloc>()
//                                         .add(FavoritedLoadEvent());
//                                   },
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     )
//                   ],
//                 ),
//               );
//             } else if (state is FavoritedFailureState) {
//               return Text(
//                 state.message.toString(),
//               );
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }
