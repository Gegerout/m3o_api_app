import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m30_api_app/auth/data/repository/data_repository.dart';

final signinProvider = ChangeNotifierProvider((ref) => signinNotifier());

class signinNotifier extends ChangeNotifier {
  bool isEmail = true;
  bool isPassword = true;
  bool isValid = false;

  void checkEmail(String email) {
    if(RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      isEmail = true;
    }
    else {
      isEmail = false;
    }

    if(isEmail && isPassword) {
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

    if(isEmail && isPassword) {
      isValid = true;
    }
    else {
      isValid = false;
    }
    notifyListeners();
  }

  void loginUser(String email, String password) async {
    final data = await DataRepository().loginUser(email, password);
  }
}