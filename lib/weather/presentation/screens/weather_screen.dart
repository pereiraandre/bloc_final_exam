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
    return BlocBuilder<WeatherCubit, WeatherState>(
      buildWhen: (oldState, newState) => newState is WeatherLoading || newState is WeatherLoaded,
      builder: (context, state) {
        if (state is WeatherLoaded) {
          var darkColor = state.weather?.isBadWeather ?? false
              ? Colors.black
              : Colors.white;
          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: state.weather?.isBadWeather ?? false
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
                        state.weather?.name == null
                            ? 'No data'
                            : '${state.weather?.name}',
                        style: kTextWeatherScreen.copyWith(color: darkColor),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 21.0),
                          child: IconButton(
                            onPressed: () {
                              if (state.isCitySaved?.contains(state.weather?.name) ?? false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('This city is already saved'),
                                        duration: Duration(seconds: 2)
                                    )
                                );
                              } else {
                                BlocProvider.of<MyCitiesCubit>(context).addCityToList(
                                    state.weather?.name
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Your city has been saved successfully'),
                                        duration: Duration(seconds: 2)
                                    ));
                              }
                            },
                            icon: const Icon(Icons.save),
                            color: state.isCitySaved?.contains(state.weather?.name) ?? false
                                ? Colors.red
                                : darkColor,
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
                            state.weather?.weather[0].main == null
                                ? 'No data'
                                : '${state.weather?.weather[0].main}',
                            style: kTextWeatherScreen,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            state.weather?.main.temp == null
                                ? 'No data'
                                : '${state.weather?.main.temp?.toInt()}º',
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
                                state.weather?.badWeatherDescription() ??
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
