import 'package:flutter/material.dart';

import 'package:note_demo/providers/users_provider.dart';
import 'package:note_demo/screens/home_screen.dart';
import 'package:note_demo/screens/homepage_old.dart';
import 'package:note_demo/screens/login_screen.dart';
import 'package:note_demo/screens/task_list_screen.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appUsers = Provider.of<AppUsers>(context);
    if (appUsers.user != null) {
      print('logged in');
      return const HomeScreen();
    } else {
      print('Not logged in');
      return LoginScreen();
    }
  }
}
