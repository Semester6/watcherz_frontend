import 'package:auto_route/annotations.dart';
import 'package:watcherz_frontend/pages/dashboard_page.dart';
import 'package:watcherz_frontend/pages/onboarding_page.dart';

import '../../pages/login_page.dart';
import '../../pages/splash_page.dart';

@AdaptiveAutoRouter(
    replaceInRouteName: 'Page,Route,Screen',
    routes: <AutoRoute>[
      AutoRoute(initial: true, path: "/initial", page: SplashPage),
      AutoRoute(path: "/onboarding", page: OnboardingPage),
      AutoRoute(path: "/login", page: LoginPage, children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ]),
      AutoRoute(path: "/dashboard", page: DashboardPage),
      // AutoRoute(path: "/reset_password", page: ResetPasswordPage, children: [
      //   RedirectRoute(path: '*', redirectTo: ''),
      // ]),
      //bottomNavRouter,
    ])
class $AppRouter {}

// const bottomNavRouter = AutoRoute(
//   path: 'menu/',
//   page: HomeScreen,
//   children: [
//     AutoRoute(
//       path: 'settings',
//       name: 'BottomNavSettingsRouter',
//       page: EmptyRouterPage,
//       children: [
//         AutoRoute(path: '', page: SettingsPage),
//         AutoRoute(path: 'about', page: AboutPage),
//         AutoRoute(path: 'licenses', page: LicensesPage),
//         AutoRoute(path: 'license_details', page: LicenseDetailPage),
//         AutoRoute(path: 'account', page: AccountPage),
//         AutoRoute(path: 'disclaimer', page: DisclaimerPage),
//         AutoRoute(path: 'disclaimer_details', page: DisclaimerDetailPage),
//         AutoRoute(path: 'author_rights', page: AuthorRightsPage),
//         AutoRoute(path: 'author_rights_details', page: AuthorRightsDetailPage),
//         AutoRoute(path: 'terms_of_service', page: TermsOfServicePage),
//         AutoRoute(
//             path: 'terms_of_service_details', page: TermsOfServiceDetailPage),
//         RedirectRoute(path: '*', redirectTo: ''),
//       ],
//     ),
//     AutoRoute(
//       path: 'customer_order',
//       name: 'BottomNavCustomerOrderRouter',
//       page: EmptyRouterPage,
//       children: [
//         AutoRoute(path: '', page: CustomerOrderPage),
//         AutoRoute(path: 'details', page: OrderDetailPage),
//         RedirectRoute(path: '*', redirectTo: ''),
//       ],
//     ),
//     AutoRoute(
//       path: 'supplier_order',
//       name: 'BottomNavSupplierOrderRouter',
//       page: EmptyRouterPage,
//       children: [
//         AutoRoute(path: '', page: SupplierOrderPage),
//         AutoRoute(path: 'details', page: OrderDetailPage),
//         RedirectRoute(path: '*', redirectTo: ''),
//       ],
//     ),
//   ],
// );
