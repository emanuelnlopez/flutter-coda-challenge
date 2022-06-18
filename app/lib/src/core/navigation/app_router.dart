import 'package:crud/src/core/core.dart';
import 'package:crud/src/features/features.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static RouteFactory get generatedRoutes => (RouteSettings settings) {
        ModalRoute? route;

        switch (settings.name) {
          case NamedRoute.createUser:
            route = MaterialPageRoute(
              builder: (_) => CreateUserScreen(),
            );
            break;
          case NamedRoute.home:
            route = MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            );
            break;
          case NamedRoute.login:
            route = MaterialPageRoute(
              builder: (_) => LoginScreen(),
            );
            break;
          case NamedRoute.splash:
            route = MaterialPageRoute(
              builder: (_) => SplashScreen(),
            );
            break;
        }

        return route;
      };
}
