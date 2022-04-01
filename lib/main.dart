import 'package:flutter/material.dart';

//flutter packages pub run build_runner watch --delete-conflicting-outputs

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:watcherz_frontend/bloc/bloc_observer.dart';

import 'bloc/authentication_bloc/authentication_bloc.dart';
import 'config/api/api_config.dart';
import 'config/route/router.gr.dart';
import 'data/data_provider/user_data_provider.dart';
import 'data/repositories/authentication_repository.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  Dio dio = ApiConfig().initDio();

  getIt.registerSingleton<AppRouter>(AppRouter());

  HydratedBlocOverrides.runZoned(
    () => runApp(App(
      authenticationRepository: AuthenticationRepository(UserDataProvider(dio)),
    )),
    storage: storage,
    blocObserver: BlocObserverDebug(),
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: authenticationRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
        ],
        child: ApplicationRouter(),
      ),
    );
  }
}

class ApplicationRouter extends StatelessWidget {
  ApplicationRouter({Key? key}) : super(key: key);
  final _router = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AutoRouterDelegate(_router),
      routeInformationParser: _router.defaultRouteParser(),
    );
  }
}
