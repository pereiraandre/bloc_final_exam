import '../../networking/networking.dart';
import '../models/weather_model.dart';

class WeatherServices {
  WeatherServices._privateConstructor();

  static final WeatherServices _instance =
      WeatherServices._privateConstructor();

  static WeatherServices get instance => _instance;
  NetworkHelper networkHelper = NetworkHelper.shared;

  Future<Weather?> getCoordinates(String lat, String long) async {
    try {
      var response = await networkHelper.get(
        '?lat=$lat&lon=$long&appid=',
      );
      var weatherMap = Map<String, dynamic>.from(response);
      Weather weather = Weather.fromJson(weatherMap);
      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
