import 'package:bloc_final_exame/weather/bloc/my_cities_cubit.dart';
import 'package:bloc_final_exame/weather/bloc/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/constants/constants.dart';
import '../widgets/weather_container_widget.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ));
    }

    return BlocBuilder<WeatherCubit, WeatherState>(
      buildWhen: (oldState, newState) =>
          newState is WeatherLoading || newState is WeatherLoaded,
      builder: (context, state) {
        if (state is WeatherLoaded) {
          var weather = state.weather;
          var darkColor =
              weather?.isBadWeather ?? false ? Colors.black : Colors.white;
          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: weather?.isBadWeather ?? false
                        ? const AssetImage('images/bad_weather.png')
                        : const AssetImage('images/good_weather.png'),
                    fit: BoxFit.cover),
              ),
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      leading: BackButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        color: darkColor,
                      ),
                      title: Text(
                        weather?.name == null ? 'No data' : '${weather?.name}',
                        style: kTextWeatherScreen.copyWith(color: darkColor),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 21.0),
                          child: InkWell(
                            onTap: () {
                              if (state.isCitySaved?.contains(weather?.name) ??
                                  false) {
                                showSnackBar('This city is already saved');
                              } else {
                                BlocProvider.of<MyCitiesCubit>(context)
                                    .addCityToList(weather?.name);
                                showSnackBar(
                                    'Your city has been saved successfully');
                              }
                            },
                            splashFactory: InkRipple.splashFactory,
                            highlightColor:
                                (state.isCitySaved?.contains(weather?.name) ??
                                        false)
                                    ? Colors.transparent
                                    : Colors.green.withOpacity(0.9),
                            splashColor:
                                (state.isCitySaved?.contains(weather?.name) ??
                                        false)
                                    ? Colors.transparent
                                    : Colors.green.withOpacity(0.9),
                            customBorder: const CircleBorder(),
                            child: Icon(
                              Icons.save,
                              color:
                                  (state.isCitySaved?.contains(weather?.name) ??
                                          false)
                                      ? Colors.red
                                      : darkColor,
                            ),
                          ),
                        ),
                      ]),
                  body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 68.0, right: 20),
                          child: Text(
                            weather?.weather[0].main == null
                                ? 'No data'
                                : '${weather?.weather[0].main}',
                            style: kTextWeatherScreen,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            weather?.main.temp == null
                                ? 'No data'
                                : '${weather?.main.temp?.toInt()}º',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 70.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              top: 116.0,
                              bottom: 116.0),
                          child: SizedBox(
                            height: 144.0,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: state.listWeatherValues?.length ?? 0,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                width: 15.0,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return WeatherResponse(
                                    titleText: state
                                        .listWeatherValues![index].titleText,
                                    value:
                                        state.listWeatherValues![index].value);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 130.0,
                            right: 25.0,
                            left: 25.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                weather?.badWeatherDescription() ??
                                    'No description available',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        }
        return Container();
      },
    );
  }
}
