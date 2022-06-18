import 'package:crud/src/core/core.dart';
import 'package:crud/src/features/features.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static RouteFactory get generatedRoutes => (RouteSettings settings) {
        ModalRoute? route;

        var argumentsMap = settings.arguments as Map<String, dynamic>?;

        switch (settings.name) {
          case NamedRoute.createUser:
            route = MaterialPageRoute(
              builder: (_) => CreateUserScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
            break;
          case NamedRoute.home:
            route = MaterialPageRoute(
              builder: (_) => const HomeScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
            break;
          case NamedRoute.login:
            route = MaterialPageRoute(
              builder: (_) => LoginScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
            break;
          case NamedRoute.splash:
            route = MaterialPageRoute(
              builder: (_) => SplashScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
            break;
        }

        return route;
      };
}
