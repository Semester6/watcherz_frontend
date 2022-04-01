part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    //TODO: CHANGE WHEN AUTH SERVICE HAS BEEN MADE!!
    this.status = AuthenticationStatus.authenticated,
    this.user = const User(
        id: 1,
        firstName: "Sharony",
        lastName: "Braam",
        email: "1234@gmail.com",
        token: '1234'),
    this.process = FormzStatus.submissionSuccess,
    this.loginModel = const LoginModel(username: "Sharony", password: "1234"),
    this.token = "1234",
  });

  const AuthenticationState.unknown() : this();

  const AuthenticationState.authenticated(
      User user, String token, FormzStatus process, LoginModel loginModel)
      : this(
            status: AuthenticationStatus.authenticated,
            user: user,
            token: token,
            process: process,
            loginModel: loginModel);

  const AuthenticationState.unauthenticated(LoginModel loginModel)
      : this(
            status: AuthenticationStatus.unauthenticated,
            loginModel: loginModel);

  final AuthenticationStatus status;
  final User user;
  final FormzStatus process;
  final LoginModel loginModel;
  final String token;

  @override
  List<Object> get props => [status, user, process, loginModel, token];

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    User? user,
    FormzStatus? process,
    LoginModel? loginModel,
    String? token,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
      process: process ?? this.process,
      loginModel: loginModel ?? this.loginModel,
      token: token ?? this.token,
    );
  }
}
