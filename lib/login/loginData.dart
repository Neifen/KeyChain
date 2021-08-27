import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginData extends ChangeNotifier {
  static const List admins = ["nate.bourquin@gmail.com"];

  User? getUser() {
    print("start getUser");

    return FirebaseAuth.instance.currentUser;
  }

  bool isAdmin() {
    var currentUser = getUser();
    if (currentUser == null) {
      print("no user");
      return false;
    }

    return admins.contains(currentUser.email);
  }

  Future login(BuildContext context,
      {required String email, required String password}) async {
    User? user;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      handleAuthExceptions(context, e);
    }

    notifyListeners();
    return user;
  }

  Future createUser(BuildContext context,
      {required String email, required String password}) async {
    User? user;

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      handleAuthExceptions(context, e);
    }
    notifyListeners();
    return user;
  }

  void handleAuthExceptions(context, e) {
    String message;
    if (e.code == 'user-not-found') {
      message = 'No user found for that email.';
    } else if (e.code == 'email-already-in-use') {
      message = 'Email is already in use.';
    } else if (e.code == 'weak-password') {
      message = 'Password is too weak. Try adding a number.';
    } else if (e.code == 'wrong-password') {
      message = 'Wrong password provided for that user.';
    } else {
      message = e.toString();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
    print("logged out");
  }

  bool isLoggedIn() {
    return getUser() != null;
  }
}
