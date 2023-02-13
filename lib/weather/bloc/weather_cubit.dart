import 'package:bloc/bloc.dart';
import 'package:bloc_final_exame/weather/provider/data_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:meta/meta.dart';
import '../data/weather_service.dart';
import '../models/weather_model.dart';
import '../presentation/widgets/weather_container_widget.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  final WeatherServices weatherServices = WeatherServices.instance;
  final LocalStorage localStorage = LocalStorage();

  Future<void> getWeather(String name) async {
    emit(WeatherLoading());

    try {
      List<Location> locations = await locationFromAddress(name);
      if (locations.isNotEmpty) {
        String? lat = locations.first.latitude.toString();
        String? long = locations.first.longitude.toString();
        final Weather? weather =
            await weatherServices.getCoordinates(lat, long);

        List<String> isCitySaved = (await localStorage.getCity('savedCity')) != null
            ? List<String>.from(await localStorage.getCity('savedCity'))
            : [];

        emit(WeatherLoaded(
          weather: weather,
          listWeatherValues: populateWeatherList(weather),
          isCitySaved: isCitySaved
        ));

      }
    } catch (e) {
      emit(WeatherError(errorMessage: e.toString()));
    }
  }

  List<WeatherResponse> populateWeatherList(Weather? weather) {
    List<WeatherResponse> listWeatherValues = [
      WeatherResponse(
        titleText: 'Humidity',
        value: weather?.main.humidity == null
            ? 'No data'
            : '${weather?.main.humidity?.toInt()}%',
      ),
      WeatherResponse(
          titleText: 'Sea Level',
          value: weather?.main.seaLevel == null
              ? 'No data'
              : '${weather?.main.seaLevel?.toInt()}m'),
      WeatherResponse(
          titleText: 'Wind',
          value: weather?.wind.speed == null
              ? 'No data'
              : '${weather?.wind.speed?.toInt()}km/h')
    ];
    return listWeatherValues;
  }
}
