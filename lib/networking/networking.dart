import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'app_exception.dart';

class NetworkHelper {
  final String baseUrl;
  final String apiKey;
  final String unitsMetric;
  final Dio dio;

  static NetworkHelper shared = NetworkHelper(Dio(),
      baseUrl: 'http://api.openweathermap.org/data/2.5/weather',
      apiKey: '69bdcf592dddb1852a6b57abf8b2737d',
      unitsMetric: '&units=metric');

  NetworkHelper(this.dio,
      {required this.baseUrl, required this.apiKey, required this.unitsMetric});

  Future<dynamic> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    dynamic responseJson;
    try {
      final response = await dio.get(baseUrl + url + apiKey + unitsMetric,
          queryParameters: queryParameters);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on PlatformException catch (e) {
      throw FetchDataException('Error communicating with server: ${e.message}');
    } catch (e) {
      throw FetchDataException('Error communicating with server');
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        return responseJson;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
