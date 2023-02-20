import 'package:bloc_final_exame/utils/constants/constants.dart';
import 'package:bloc_final_exame/weather/bloc/my_cities_cubit.dart';
import 'package:bloc_final_exame/weather/bloc/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/saved_cities_widget.dart';

class MySavedCities extends StatelessWidget {
  const MySavedCities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/saved_city.jpg'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'My Saved Cities',
            style: kTextSavedCitiesTitle,
          ),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 22, left: 64.0, right: 64.0),
              child: BlocConsumer<MyCitiesCubit, MyCitiesState>(
                listenWhen: (oldState, newState) => newState is MyCitiesError,
                listener: (context, state) {
                  if (state is MyCitiesError) {
                    Fluttertoast.showToast(
                        msg: state.errorMessage.toString(),
                        gravity: ToastGravity.CENTER);
                    Navigator.pushNamed(context, '/saved_city');
                  }
                },
                bloc: BlocProvider.of<MyCitiesCubit>(context)..showCitiesList(),
                buildWhen: (oldState, newState) => newState is MyCitiesLoaded,
                builder: (context, state) {
                  if (state is MyCitiesLoaded) {
                    return ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return SavedCitiesContainer(
                            delete: () {
                              BlocProvider.of<MyCitiesCubit>(context)
                                  .removeCityFromList(state.lastCity,
                                      state.lastCity![index].toString());
                            },
                            cityName: state.lastCity![index].toString(),
                            onPressed: () {
                             // Navigator.pushNamed(context, '/saved_city_loading');
                              BlocProvider.of<WeatherCubit>(context).getWeather(
                                  state.lastCity![index].toString());
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                              height: 24.0,
                            ),
                        itemCount: state.lastCity?.length ?? 0);
                  }
                  return Container();
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
