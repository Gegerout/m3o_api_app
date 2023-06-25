import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m30_api_app/auth/data/repository/data_repository.dart';

final signupProvider = ChangeNotifierProvider((ref) => signupNotifier());

class signupNotifier extends ChangeNotifier {
  bool isEmail = true;
  bool isPassword = true;
  bool isName = true;
  bool isValid = false;

  void checkName(String name) {
    if(name.length > 2) {
      isName = true;
    }
    else {
      isName = false;
    }

    if(isEmail && isPassword && isName) {
      isValid = true;
    }
    else {
      isValid = false;
    }
    notifyListeners();
  }

  void checkEmail(String email) {
    if(RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      isEmail = true;
    }
    else {
      isEmail = false;
    }

    if(isEmail && isPassword && isName) {
      isValid = true;
    }
    else {
      isValid = false;
    }
    notifyListeners();
  }

  void checkPassword(String password) {
    if(password.length > 7) {
      isPassword = true;
    }
    else {
      isPassword = false;
    }

    if(isEmail && isPassword && isName) {
      isValid = true;
    }
    else {
      isValid = false;
    }
    notifyListeners();
  }

  Future<bool> createUser(String email, String password, String username) async {
    final data = DataRepository().createUser(email, password, username);
    return data;
  }
}