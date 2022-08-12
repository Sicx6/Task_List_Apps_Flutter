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

  AppUsers._() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      // if (user != null) {
      //   this.user = user;
      // } else {
      //   this.user = null;
      // }
      notifyListeners();
    });
  }

  factory AppUsers() => AppUsers._();

  static AppUsers get instance => AppUsers();

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
      } else {
        throw (e.toString());
      }
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      user!.updateDisplayName(name);
      // return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      throw (e.toString());
    }
    return true;
  }
}
