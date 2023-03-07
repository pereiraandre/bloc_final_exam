import 'package:bloc_final_exame/routes/routes.dart';
import 'package:bloc_final_exame/utils/constants/constants.dart';
import 'package:bloc_final_exame/weather/bloc/weather_cubit.dart';
import 'package:bloc_final_exame/weather/presentation/screens/first_screen.dart';
import 'package:bloc_final_exame/weather/presentation/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/home_page.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 21, left: 21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child:
                      Text('Should I go fishing?', style: kTextHomeScreenTitle),
                ),
                const SizedBox(
                  height: 14.0,
                ),
                BlocConsumer<WeatherCubit, WeatherState>(
                  listenWhen: (oldState, newState) =>
                      newState is WeatherLoaded || newState is WeatherError,
                  listener: (context, state) {
                    if (state is WeatherLoaded) {
                      Navigator.pushNamed(context, RoutePaths.weather);
                    } else if (state is WeatherError) {
                      Fluttertoast.showToast(
                          msg: state.errorMessage.toString(),
                          gravity: ToastGravity.CENTER);
                    }
                  },
                  buildWhen: (oldState, newState) =>
                      newState is WeatherLoading || newState is WeatherInitial,
                  builder: (context, state) {
                    if (state is WeatherLoading) {
                      return const LoadingScreen();
                    }
                    return FirstScreen(myController);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
