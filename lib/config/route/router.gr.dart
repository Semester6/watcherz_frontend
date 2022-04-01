// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:watcherz_frontend/pages/dashboard_page.dart' as _i4;
import 'package:watcherz_frontend/pages/login_page.dart' as _i3;
import 'package:watcherz_frontend/pages/onboarding_page.dart' as _i2;
import 'package:watcherz_frontend/pages/splash_page.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.SplashPage());
    },
    OnboardingPageRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.OnboardingPage());
    },
    LoginPageRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.LoginPage());
    },
    DashboardPageRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.DashboardPage());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig('/#redirect',
            path: '/', redirectTo: '/initial', fullMatch: true),
        _i5.RouteConfig(SplashPageRoute.name, path: '/initial'),
        _i5.RouteConfig(OnboardingPageRoute.name, path: '/onboarding'),
        _i5.RouteConfig(LoginPageRoute.name, path: '/login', children: [
          _i5.RouteConfig('*#redirect',
              path: '*',
              parent: LoginPageRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i5.RouteConfig(DashboardPageRoute.name, path: '/dashboard')
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashPageRoute extends _i5.PageRouteInfo<void> {
  const SplashPageRoute() : super(SplashPageRoute.name, path: '/initial');

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [_i2.OnboardingPage]
class OnboardingPageRoute extends _i5.PageRouteInfo<void> {
  const OnboardingPageRoute()
      : super(OnboardingPageRoute.name, path: '/onboarding');

  static const String name = 'OnboardingPageRoute';
}

/// generated route for
/// [_i3.LoginPage]
class LoginPageRoute extends _i5.PageRouteInfo<void> {
  const LoginPageRoute({List<_i5.PageRouteInfo>? children})
      : super(LoginPageRoute.name, path: '/login', initialChildren: children);

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i4.DashboardPage]
class DashboardPageRoute extends _i5.PageRouteInfo<void> {
  const DashboardPageRoute()
      : super(DashboardPageRoute.name, path: '/dashboard');

  static const String name = 'DashboardPageRoute';
}
