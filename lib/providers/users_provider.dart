import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class AppUsers extends ChangeNotifier {
  // bool loggedIn = false;
  // User? user;

  User? get user => FirebaseAuth.instance.currentUser;

  update() {
    notifyListeners();
  }

  AppUsers.instance() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      // if (user != null) {
      //   this.user = user;
      // } else {
      //   this.user = null;
      // }
      notifyListeners();
    });
  }

  factory AppUsers() => AppUsers.instance();

  // static AppUsers get instance => AppUsers();

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  signIn({required String email, required String password}) async {
    print('email: $email');
    print('password: $password');

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print('sign in successful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print('sign up succesful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
