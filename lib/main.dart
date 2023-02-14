import 'package:bloc_final_exame/routes/routes.dart';
import 'package:bloc_final_exame/weather/bloc/my_cities_cubit.dart';
import 'package:bloc_final_exame/weather/bloc/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  AppRouter appRouter = AppRouter();

  MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (BuildContext context) => WeatherCubit(),
        ),
        BlocProvider<MyCitiesCubit>(
          create: (BuildContext context) => MyCitiesCubit(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
