import 'dart:async';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcherz_frontend/data/models/user/user.dart';

import '../data_provider/user_data_provider.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final StreamController<AuthenticationStatus> _controller = BehaviorSubject();

  UserDataProvider userDataProvider;

  AuthenticationRepository(this.userDataProvider) {
    Dio dio = Dio();
    userDataProvider = UserDataProvider(dio);
  }

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(milliseconds: 1));
    //CHANGE WHEN AUTH SERVICE IS MADE!!
    yield AuthenticationStatus.authenticated;
    yield* _controller.stream;
  }

  Future<User?> logIn({
    required String username,
    required String password,
  }) async {
    User user = User.empty;
    user = await userDataProvider.login(username, password);
    if (user != User.empty) {
      return user;
    } else {
      return User.empty;
    }
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void userAuthenticated(User user) async {
    if (user != User.empty) {
      await Future.delayed(const Duration(milliseconds: 1),
          () => _controller.add(AuthenticationStatus.authenticated));
    } else {
      await Future.delayed(
        const Duration(milliseconds: 1),
        () => _controller.add(AuthenticationStatus.unauthenticated),
      );
    }
  }

  void dispose() => _controller.close();
}
