import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watcherz_frontend/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:watcherz_frontend/config/route/router.gr.dart';

import '../data/repositories/authentication_repository.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Splash page"),
      ),
      //TODO: CHANGE TO USERBLOC WHENEVER AUTH SERVICE HAS BEEN MADE!!
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              AutoRouter.of(context).replaceAll([const DashboardPageRoute()]);
              break;
            case AuthenticationStatus.unauthenticated:
              AutoRouter.of(context).replaceAll([const LoginPageRoute()]);
              break;
            case AuthenticationStatus.unknown:
              AutoRouter.of(context).replaceAll([const OnboardingPageRoute()]);
              break;
            default:
              Container();
              break;
          }
          return Container();
        },
      ),
    );
  }
}
