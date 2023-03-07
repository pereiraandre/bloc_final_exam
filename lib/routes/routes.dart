import 'package:bloc_final_exame/weather/presentation/screens/saved_cities_screen.dart';
import 'package:flutter/material.dart';
import '../weather/presentation/screens/first_screen.dart';
import '../weather/presentation/screens/home_screen.dart';
import '../weather/presentation/screens/loading_screen.dart';
import '../weather/presentation/screens/weather_screen.dart';

class RoutePaths {
  static const String home = '/';
  static const String weather = '/weather';
  static const String firstScreen = '/first_screen';
  static const String loadingScreen = '/loading_screen';
  static const String savedCities = '/saved_cities';
}

class AppRouter {
  final myController = TextEditingController();

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RoutePaths.weather:
        return MaterialPageRoute(builder: (_) => const WeatherScreen());
      case RoutePaths.firstScreen:
        return MaterialPageRoute(builder: (_) => FirstScreen(myController));
      case RoutePaths.loadingScreen:
        return MaterialPageRoute(builder: (_) => const LoadingScreen());
      case RoutePaths.savedCities:
        return MaterialPageRoute(builder: (_) => const MySavedCities());
      default:
        return null;
    }
  }
}
