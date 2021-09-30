import 'package:date_dif/controller/home_controller.dart';
import 'package:date_dif/controller/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (home) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text('Difference between dates'.toUpperCase()),
                centerTitle: true,
                actions: [
                  IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.signOutAlt,
                      ),
                      onPressed: () {
                        home.logout();
                      }),
                ],
              ),
              body: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'this app shows us what \nis the difference between two dates.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    home.datePresent(context, 0);
                                  },
                                  color: Colors.yellow,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const ListTile(
                                    leading: Icon(
                                      Icons.touch_app,
                                      color: Colors.black,
                                    ),
                                    title: Text('First Date',
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                                SizedBox(
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: (home.dateOne == '')
                                          ? 'Select Date'
                                          : home.dateOne,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    home.datePresent(context, 1);
                                  },
                                  color: Colors.orange,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const ListTile(
                                    leading: Icon(
                                      Icons.touch_app,
                                      color: Colors.black,
                                    ),
                                    title: Text('Second Date',
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                                SizedBox(
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: (home.dateTwo == '')
                                          ? 'Select Date'
                                          : home.dateTwo,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Respuesta:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                      child: TextField(
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: (home.dateOne != '' && home.dateTwo != '')
                              ? home.difference()
                              : 'Please enter two dates',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user.photoURL!),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'User: ${user.displayName!}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Email: ${user.email!}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
