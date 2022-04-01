import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcherz_frontend/data/models/user/user.dart';

import '../../config/api/api_config.dart';

class UserDataProvider {
  final Dio _client = ApiConfig().initDio();

  UserDataProvider(_client);

  Future<User> login(String username, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await _client.post(
        "/login",
      );
      if (response.data != null) {
        User user = User.fromJson(response.data);
        String? token = response.headers.value("Bearer");
        if (token != null) {
          prefs.setString("Bearer", token);
        } else {
          return User.empty;
        }
        return user;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return User.empty;
    }
    return User.empty;
  }
}
