import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/login/login_model.dart';
import '../../data/models/user/user.dart';
import '../../data/repositories/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        //TODO: CHANGE WHENEVER AUTH SERVICE IS MADE!!
        super(const AuthenticationState.authenticated(
            User(
                id: 1,
                firstName: "Sharony",
                lastName: "Braam",
                email: "1234@gmail.com",
                token: '1234'),
            "1234",
            FormzStatus.submissionSuccess,
            LoginModel(username: "", password: ""))) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(AuthenticationState.unauthenticated(state.loginModel));
      case AuthenticationStatus.authenticated:
        LoginModel loginModel = LoginModel.empty;
        return emit(AuthenticationState.authenticated(
          state.user,
          state.token,
          state.process,
          loginModel,
        ));
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    final username = event.username;
    final loginModel =
        LoginModel(username: username, password: state.loginModel.password);
    emit(
      state.copyWith(loginModel: loginModel),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    final password = event.password;
    final loginModel =
        LoginModel(username: state.loginModel.username, password: password);
    emit(
      state.copyWith(
        loginModel: loginModel,
      ),
    );
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(process: FormzStatus.submissionInProgress));
    try {
      final response = await _authenticationRepository.logIn(
        username: state.loginModel.username,
        password: state.loginModel.password,
      );
      if (response != User.empty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString("Bearer");
        emit(state.copyWith(
          process: FormzStatus.submissionSuccess,
          user: response,
          token: token,
        ));
      } else {
        emit(state.copyWith(process: FormzStatus.submissionFailure));
      }
      _authenticationRepository.userAuthenticated(response!);
    } catch (_) {
      emit(state.copyWith(process: FormzStatus.submissionFailure));
    }
  }
}
