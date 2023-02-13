// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) => WeatherData(
      json['main'] as String?,
    );

Map<String, dynamic> _$WeatherDataToJson(WeatherData instance) =>
    <String, dynamic>{
      'main': instance.main,
    };

MainData _$MainDataFromJson(Map<String, dynamic> json) => MainData(
      (json['temp'] as num?)?.toDouble(),
      json['humidity'] as int?,
      json['sea_level'] as int?,
    );

Map<String, dynamic> _$MainDataToJson(MainData instance) => <String, dynamic>{
      'temp': instance.temp,
      'sea_level': instance.seaLevel,
      'humidity': instance.humidity,
    };

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
      (json['speed'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      json['name'] as String,
      (json['weather'] as List<dynamic>)
          .map((e) => WeatherData.fromJson(e as Map<String, dynamic>))
          .toList(),
      MainData.fromJson(json['main'] as Map<String, dynamic>),
      Wind.fromJson(json['wind'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'name': instance.name,
      'weather': instance.weather,
      'main': instance.main,
      'wind': instance.wind,
    };
