import 'dart:convert';
import 'dart:io';
import 'package:m30_api_app/auth/data/models/user_model.dart';
import 'package:path_provider/path_provider.dart';

class LocalData {
  Future<UserModel?> getUser() async {
    var dir = await getTemporaryDirectory();
    final File file = File("${dir.path}/userData.json");
    if(file.existsSync()) {
      final model = UserModel.fromJson(json.decode(file.readAsStringSync()));
      return model;
    }
    return null;
  }
}