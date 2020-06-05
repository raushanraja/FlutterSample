import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  Map currentUser;

  AuthService() {
    print("Instantiating new AuthService");
  }

  Future getUser() {
    return Future.value(currentUser);
  }

  Future logOut() {
    this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }

  Future login({String id, String password}) {
    if (password == "raushan" && id == "raushan") {
      this.currentUser = {"user": "raushan"};
      return Future.value(currentUser);
    } else {
      this.currentUser = null;
      return Future.value(null);
    }
  }

  
}
