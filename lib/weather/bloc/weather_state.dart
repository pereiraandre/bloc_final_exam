part of 'weather_cubit.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final List<WeatherResponse> listWeatherValues;
  final Weather? weather;
  final List<String> savedCityList;
  final bool isCitySaved;

  WeatherLoaded(
      {this.weather,
      required this.listWeatherValues,
      required this.savedCityList,
      required this.isCitySaved});
}

class WeatherError extends WeatherState {
  final String errorMessage;

  WeatherError({required this.errorMessage});
}
