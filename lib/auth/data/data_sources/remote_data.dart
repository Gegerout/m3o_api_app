import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../models/user_model.dart';

class RemoteData {
  Future<UserModel?> loginUser() async {
    const String apiUrl = "https://api.m3o.com/v1/user/Login";
    final Dio dio = Dio();
    var dir = await getTemporaryDirectory();
    final File file = File("${dir.path}/userData.json");
    final data = await dio.get(apiUrl);
    if(data.statusCode == 200) {
      final model = UserModel.fromJson(data.data);
      file.writeAsStringSync(json.encode(data.data));
      return model;
    }
    else {
      return null;
    }
  }
}