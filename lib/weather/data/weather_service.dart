import '../../networking/networking.dart';
import '../models/weather_model.dart';

class WeatherServices {
  WeatherServices._privateConstructor();

  static final WeatherServices _instance =
      WeatherServices._privateConstructor();

  static WeatherServices get instance => _instance;

  Future<Weather?> getCoordinates(String lat, String long) async {
    NetworkHelper networkHelper = NetworkHelper.shared;

    try {
      var response = await networkHelper.get(
        '?lat=$lat&lon=$long&appid=',
      );
      if(response.statusCode == 200){
        var weatherMap = response.data;
        Weather weather = Weather.fromJson(weatherMap);
        return weather;
      }
    }catch(e){
      rethrow;
    }
  }
}
