import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginData extends ChangeNotifier {
  static const List admins = ["nate.bourquin@gmail.com"];
  User? currentUser;

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

  Future login({required String email, required String password}) async {
    User? user;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    notifyListeners();
    return user;
  }

//todo: remove ?
  Future createUser(
      {String? firstName,
      String? lastName,
      String? email,
      String? password}) async {}

  void logout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
    print("logged out");
  }

  bool isLoggedIn() {
    return getUser() != null;
  }
}
