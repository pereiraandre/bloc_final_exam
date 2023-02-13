import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String baseUrl;
  final String apiKey;
  final String unitsMetric;
  final Dio dio;

  static NetworkHelper shared =
      NetworkHelper(Dio(), baseUrl: 'http://api.openweathermap.org/data/2.5/weather', apiKey: '69bdcf592dddb1852a6b57abf8b2737d', unitsMetric: '&units=metric');

  NetworkHelper(this.dio, {required this.baseUrl, required this.apiKey, required this.unitsMetric});

  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters}) async {
    final response = await dio.get(baseUrl + url + apiKey + unitsMetric, queryParameters: queryParameters);

    return response;
  }
}
