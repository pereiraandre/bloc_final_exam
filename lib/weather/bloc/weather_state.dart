part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final List<WeatherResponse>? listWeatherValues;
  final Weather? weather;
  final List<String>? isCitySaved;

  WeatherLoaded({this.weather, this.listWeatherValues, this.isCitySaved});
}

class WeatherError extends WeatherState {
  final String errorMessage;

  WeatherError({required this.errorMessage});
}
