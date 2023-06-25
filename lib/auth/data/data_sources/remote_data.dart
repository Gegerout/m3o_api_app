import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../models/user_model.dart';

class RemoteData {
  static const String apiKey = "";

  Future<UserModel?> loginUser(String email, String password) async {
    const String apiUrl = "https://api.m3o.com/v1/user/Login";
    final Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer $apiKey";
    var dir = await getTemporaryDirectory();
    final File file = File("${dir.path}/userData.json");
    final data = await dio.post(apiUrl, data: {
      "email": email,
      "password": password
    }, options: Options(
      validateStatus: (status) {
        return status! <= 500;
      }
    ));
    if(data.statusCode == 200) {
      final model = UserModel.fromJson(data.data["session"]);
      file.writeAsStringSync(json.encode(data.data));
      return model;
    }
    else {
      return null;
    }
  }

  Future<bool> createUser(String email, String password, String username) async {
    const String apiUrl = "https://api.m3o.com/v1/user/Create";
    final Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer $apiKey";
    final data = await dio.post(apiUrl, data: {
      "email": email,
      "password": password,
      "username": username
    }, options: Options(
        validateStatus: (status) {
          return status! < 500;
        }
    ));
    if(data.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }
}