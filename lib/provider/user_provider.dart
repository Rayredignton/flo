import 'package:flutter/widgets.dart';
import 'package:flo/models/user.dart';
import 'package:flo/resources/firebase_methods.dart';

class UserProvider with ChangeNotifier {
  User _user;
  AuthMethods _authMethods = AuthMethods();

  User get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

}