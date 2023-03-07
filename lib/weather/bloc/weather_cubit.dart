import 'package:bloc/bloc.dart';
import 'package:bloc_final_exame/weather/provider/data_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import '../data/weather_service.dart';
import '../models/weather_model.dart';
import '../presentation/widgets/weather_container_widget.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final CityDataProvider cityDataProvider;

  WeatherCubit(this.cityDataProvider) : super(WeatherInitial());

  final WeatherServices weatherServices = WeatherServices.instance;

  void reset() {
    emit(WeatherInitial());
  }

  Future<void> getWeather(String name) async {
    emit(WeatherLoading());

    try {
      List<Location> locations = await locationFromAddress(name);
      if (locations.isNotEmpty) {
        String? lat = locations.first.latitude.toString();
        String? long = locations.first.longitude.toString();
        final Weather? weather =
            await weatherServices.getCoordinates(lat, long);

        List<String> savedCityList =
            (await cityDataProvider.getCity('savedCity')) != null
                ? List<String>.from(await cityDataProvider.getCity('savedCity'))
                : [];

        List<WeatherResponse>? finalPopulateWeatherList =
            populateWeatherList(weather!);
        bool isCitySaved = savedCityList.contains(weather.name);

        emit(
          WeatherLoaded(
              weather: weather,
              listWeatherValues: finalPopulateWeatherList,
              savedCityList: savedCityList,
              isCitySaved: isCitySaved),
        );
      }
    } catch (e) {
      emit(WeatherError(errorMessage: e.toString()));
      emit(WeatherInitial());
    }
  }

  List<WeatherResponse> populateWeatherList(Weather weather) {
    List<WeatherResponse> listWeatherValues = [
      WeatherResponse(
        titleText: 'Humidity',
        value: weather.main.humidity == null
            ? 'No data'
            : '${weather.main.humidity?.toInt()}%',
      ),
      WeatherResponse(
          titleText: 'Sea Level',
          value: weather.main.seaLevel == null
              ? 'No data'
              : '${weather.main.seaLevel?.toInt()}m'),
      WeatherResponse(
          titleText: 'Wind',
          value: weather.wind.speed == null
              ? 'No data'
              : '${weather.wind.speed?.toInt()}km/h')
    ];
    return listWeatherValues;
  }
}
