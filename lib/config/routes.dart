// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simba_courier/core/utils/search_screen.dart';
import 'package:simba_courier/features/home/presentation/drawer_pages/privacy.dart';
import 'package:simba_courier/features/home/presentation/drawer_pages/terms.dart';
import 'package:simba_courier/features/home/presentation/pages/home_layer.dart';
import 'package:simba_courier/features/home/presentation/drawer_pages/offline_sync.dart';
import 'package:simba_courier/features/home/presentation/drawer_pages/two_factor.dart';
import 'package:simba_courier/features/login_home/data/models/login_model.dart';
import 'package:simba_courier/features/login_home/presentation/pages/forget_password.dart';
import 'package:simba_courier/features/login_home/presentation/pages/login.dart';
import 'package:simba_courier/features/login_home/presentation/pages/signup.dart';
import 'package:simba_courier/features/login_home/presentation/pages/signup2.dart';
import 'package:simba_courier/features/login_home/presentation/pages/splash.dart';

import '../features/home/presentation/drawer_pages/help_support.dart';

class Routes {
  static const String splash = '/';
  static const String initialRoute = '/login';
  static const String forgetPassword = '/login/forgetPaswword';
  static const String signup = '/signup';
  static const String signup_2 = '/signup2';
  static const String home_layer = '/home';
  static const String pick_detials = '/pickupDetails';
  static const String search = '/search';
  static const String two_factor = '/twoFactor';
  static const String offline_sync = '/offlineSync';
  static const String help_support = '/helpAndSupport';
  static const String terms = '/terms';
  static const String privacy = '/privacy';
}

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final LoginModel? model = settings.arguments as LoginModel?;

    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) => Login());
      case Routes.search:
        return MaterialPageRoute(builder: (context) => const SearchScreen());

      case Routes.splash:
        return PageTransition(
            type: PageTransitionType.rightToLeft, child: const Splash());
      case Routes.forgetPassword:
        return PageTransition(
            type: PageTransitionType.rightToLeft, child: ForgetPassword());
      case Routes.signup:
        return PageTransition(
            type: PageTransitionType.rightToLeft, child: const Signup());

      case Routes.signup_2:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const Signup2(args: ''),
        );
      case Routes.home_layer:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: HomeLayer(model: model),
        );

      case Routes.two_factor:
        return PageTransition(
          type: PageTransitionType.leftToRight,
          child: TwoFactor(),
        );
      case Routes.offline_sync:
        return PageTransition(
          type: PageTransitionType.leftToRight,
          child: const OfflineSync(),
        );
      case Routes.help_support:
        return PageTransition(
          type: PageTransitionType.leftToRight,
          child: const HelpSupport(arg: ''),
        );
      case Routes.terms:
        return PageTransition(
          type: PageTransitionType.leftToRight,
          child: const Terms(arg: ''),
        );
      case Routes.privacy:
        return PageTransition(
          type: PageTransitionType.leftToRight,
          child: const Privacy(arg: ''),
        );

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                body: Center(child: Text('No Route Exist  ${settings.name}'))));
    }
  }
}
