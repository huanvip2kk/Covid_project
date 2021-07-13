import 'package:covid_19/config/app_config.dart';
import 'package:covid_19/presentation/common/common_widget.dart';
import 'package:covid_19/presentation/profile/profile_bloc/profile_bloc.dart';
import 'package:covid_19/utils/route/app_routing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  String? imageUrl;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  _showPicker() {
    final _picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.image, color: AppConfig.kPrimaryColor),
              title: const Text(
                'Gallery',
              ),
              onTap: () async {
                await _picker.getImage(source: ImageSource.gallery);

                //Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.camera_alt,
                color: AppConfig.kPrimaryColor,
              ),
              title: const Text('Camera'),
              onTap: () async {
                await _picker.getImage(source: ImageSource.camera);
                //Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppConfig.kPrimaryColor,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (bcontext, state) {
          if (state is ProfileLoadingState) {
            return loading();
          } else if (state is ProfileLoadedState) {
            if (user == null) {
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: Card(
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "You're not login? ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RouteDefine.loginScreen.name);
                                },
                                child: const Text(
                                  'login now!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 24),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8, bottom: 8),
                              child: SizedBox(
                                height: 160,
                                child: Card(
                                  elevation: 5,
                                  child: Column(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Card(
                                            color: Colors.red,
                                            elevation: 5,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.favorite,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            'Favorited',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteDefine.favoritedScreen.name);
                            },
                          ),
                        ),
                        Expanded(
                            child: GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 8),
                            child: SizedBox(
                              height: 160,
                              child: Card(
                                elevation: 5,
                                child: Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Card(
                                          color: Colors.blue,
                                          elevation: 5,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.settings,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          'Settings',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteDefine.settingsScreen.name);
                          },
                        )),
                      ],
                    ),
                  )
                ],
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Expanded(
                      child: Stack(
                        children: [
                          Card(
                            margin: const EdgeInsets.only(top: 50),
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 120,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Hello ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    Text(
                                      FirebaseAuth
                                          .instance.currentUser!.displayName
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          color: AppConfig.kPrimaryColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              child: CircleAvatar(
                                radius: 75.0,
                                backgroundColor: AppConfig.kPrimaryColor,
                                child: CircleAvatar(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20.0,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: AppConfig.kPrimaryColor,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => Form(
                                              key: _formKey,
                                              child: AlertDialog(
                                                elevation: 16,
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Change profile',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 24),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            _showPicker();
                                                          },
                                                          icon: const Icon(
                                                            FontAwesomeIcons
                                                                .cameraRetro,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          nameController,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'Title',
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      validator: (value) {
                                                        if (value != null &&
                                                            value.isNotEmpty) {
                                                          return null;
                                                        }
                                                        return 'Cannot empty!';
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                    Row(
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              'Cancel'),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            bcontext
                                                                .read<
                                                                    ProfileBloc>()
                                                                .add(
                                                                  ProfileChangeEvent(
                                                                      username:
                                                                          nameController
                                                                              .text),
                                                                );
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text('Ok'),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            barrierDismissible: true,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  radius: 60.0,
                                  backgroundImage: NetworkImage(FirebaseAuth
                                      .instance.currentUser!.photoURL
                                      .toString()),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, bottom: 8),
                                  child: SizedBox(
                                    height: 160,
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Card(
                                                color: Colors.red,
                                                elevation: 5,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                'Favorited',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      RouteDefine.favoritedScreen.name);
                                },
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, bottom: 8),
                                  child: SizedBox(
                                    height: 160,
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Card(
                                                color: Colors.blue,
                                                elevation: 5,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.settings,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                'Settings',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteDefine.settingsScreen.name);
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, right: 8),
                                  child: SizedBox(
                                    height: 160,
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Card(
                                                color: Colors.orange,
                                                elevation: 5,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.lightbulb,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                'Sthg',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 8),
                                  child: SizedBox(
                                    height: 160,
                                    child: Card(
                                      color: Colors.red,
                                      elevation: 5,
                                      child: Column(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Card(
                                                color: Colors.red,
                                                elevation: 5,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.logout,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                'Logout',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (dialogContext) => AlertDialog(
                                      title: const Text("Want to logout?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(dialogContext).pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            FirebaseAuth.instance.signOut();
                                            Navigator.pushReplacementNamed(
                                                context,
                                                RouteDefine.landingPage.name);
                                          },
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );

            /// Sthng
          } else if (state is ProfileFailureState) {
            ///Sthng
          }
          return loading();
        },
      ),
    );
  }
}
