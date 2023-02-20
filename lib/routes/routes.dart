import 'package:bloc_final_exame/weather/presentation/screens/saved_cities_screen.dart';
import 'package:flutter/material.dart';
import '../weather/presentation/screens/first_screen.dart';
import '../weather/presentation/screens/home_screen.dart';
import '../weather/presentation/screens/loading_screen.dart';
import '../weather/presentation/screens/weather_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/weather':
        return MaterialPageRoute(builder: (_) => const WeatherScreen());
      case '/first_screen':
        return MaterialPageRoute(builder: (_) => FirstScreen());
      case '/loading_screen':
        return MaterialPageRoute(builder: (_) => const LoadingScreen());
      case '/saved_city':
        return MaterialPageRoute(builder: (_) => const MySavedCities());
      default:
        return null;
    }
  }
}
