import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherData {
  final String? main;

  WeatherData(this.main);

  factory WeatherData.fromJson(Map<String, dynamic> json) => _$WeatherDataFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDataToJson(this);
}

@JsonSerializable()
class MainData {
  final double? temp;
  @JsonKey(name: 'sea_level')
  final int? seaLevel;
  final int? humidity;


  MainData(this.temp, this.humidity, this.seaLevel);

  factory MainData.fromJson(Map<String, dynamic> json) => _$MainDataFromJson(json);
  Map<String, dynamic> toJson() => _$MainDataToJson(this);
}

@JsonSerializable()
class Wind {
  final double? speed;


  Wind(this.speed);

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class Weather {
  final String name;
  final List<WeatherData> weather;
  final MainData main;
  final Wind wind;

  Weather(this.name, this.weather, this.main, this.wind);

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  String? humidityDescription() {
    if (main.humidity == null) {
      return null;
    }
    if (main.humidity! < 30) {
      return 'Low';
    } else if (main.humidity! < 50) {
      return 'Normal';
    } else if (main.humidity! < 100) {
      return 'High';
    } else {
      return null;
    }
  }

  String? seaLevelDescription() {
    if (main.seaLevel == null) {
      return null;
    }
    if (main.seaLevel! < 1000) {
      return 'Low';
    } else if (main.seaLevel! <= 2000) {
      return 'Normal';
    } else if (main.seaLevel! > 2000) {
      return 'High';
    }
    return null;
  }

  String? windLevelDescription() {
    if (wind.speed == null) {
      return null;
    }
    if (wind.speed! < 25) {
      return 'Low';
    } else if (wind.speed! <= 50) {
      return 'Normal';
    } else if (wind.speed! > 50) {
      return 'High';
    } else {
      return null;
    }
  }

  String? badWeatherDescription() {
    const String nullMessage = 'Like we Can\'t get the value from it';
    if (weather[0].main == null) {
      return null;
    }
    if (weather[0].main == 'Rain' || weather[0].main == 'Clouds') {
      return 'Humidity looks ${humidityDescription() ?? nullMessage}, sea level looks '
          '${seaLevelDescription() ?? nullMessage} '
          'and wind looks ${windLevelDescription() ?? nullMessage}, '
          'Let\'s get the fish from the supermarket instead';
    }
    return 'Humidity looks ${humidityDescription() ?? nullMessage}, sea level looks '
        '${seaLevelDescription() ?? nullMessage} '
        'and wind looks ${windLevelDescription() ?? nullMessage}, '
        'Let\'s get that fishing starting, and catch some douradas to your friends';
  }

  bool get isBadWeather => weather[0].main != null && weather[0].main == 'Rain' || weather[0].main == 'Clouds';
}
