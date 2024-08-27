import 'package:flutter/material.dart';
import 'package:todo3/models/user_modwl.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;

  void updateUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }
}
